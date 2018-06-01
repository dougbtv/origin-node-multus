# origin-node-multus

An extension of the [openshift node dockerfile](https://github.com/openshift/origin/blob/master/images/node/Dockerfile), to include Multus.

Plans to use [Docker Multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/).

Ideally deployable through openshift-ansible [by modifying the osn_image variable](https://github.com/openshift/openshift-ansible/blob/03d1cd8673cdc5f1777009dcfed8abe04da3e1f8/roles/openshift_node/defaults/main.yml#L16-L17)

---


