# origin-node-multus

An extension of the [openshift node dockerfile](https://github.com/openshift/origin/blob/master/images/node/Dockerfile), to include Multus.

Plans to use [Docker Multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/).

Ideally deployable through openshift-ansible [by modifying the osn_image variable](https://github.com/openshift/openshift-ansible/blob/master/roles/openshift_node/defaults/main.yml#L101-L104)

---


