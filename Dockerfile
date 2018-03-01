# -------- Builder stage.
# Based on https://github.com/redhat-nfvpe/kube-ansible/tree/master/roles/multus-cni
FROM centos:centos7
RUN rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO && curl -s https://mirror.go-repo.io/centos/go-repo.repo | tee /etc/yum.repos.d/go-repo.repo
RUN yum install -y git golang
RUN git clone https://github.com/Intel-Corp/multus-cni.git /usr/src/multus-cni
WORKDIR /usr/src/multus-cni
RUN ./build

# -------- Import stage.
FROM openshift/node
COPY --from=0 /usr/src/multus-cni/bin/multus /opt/cni/bin
ADD multus.conf /multus.conf
ADD watcher.sh /watcher.sh
ADD entrypoint.sh /entrypoint.sh

LABEL io.k8s.display-name="OpenShift Origin Node" \
      io.k8s.description="This is a component of OpenShift Origin and contains the software for individual nodes when using SDN (with Multus)." \
      io.openshift.tags="openshift,node"

VOLUME /etc/origin/node
ENV KUBECONFIG=/etc/origin/node/node.kubeconfig

ENTRYPOINT [ "/entrypoint.sh" ]