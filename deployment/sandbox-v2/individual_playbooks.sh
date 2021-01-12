#anskip playbooks/console.yml
#anskip playbooks/coredns.yml
anskip palybooks/nginx.yml
anksip playbooks/nfs.yml
# MZ cluster
anskip playbooks/mzcluster.yml
anskip playbooks/mz-nfs-provisioner.yml
anskip playbooks/mzmonitoring.yml
anskip playbooks/taints.yml # At this point we apply any taints for MOSIP pods. 
# DMZ cluster
anskip playbooks/dmzcluster.yml
anskip playbooks/dmz-nfs-provisioner.yml
anskip playbooks/dmzmonitoring.yml
# Non-MOSIP modules
anskip playbooks/postgres.yml
anskip playbooks/keycloak.yml
anskip playbooks/mzclamav.yml  # Each zone has it's own clamav
anskip playbooks/dmzclamav.yml
anskip playbooks/activemq.yml
#anskip playbooks/mock-biosdk.yml    #TODO
anskip playbooks/minio.yml
anskip playbooks/artifactory.yml
# MOSIP modules
anskip playbooks/config-server.yml    
anskip playbooks/kernel.yml
anskip playbooks/packetmanager.yml
anskip playbooks/datashare.yml
anskip playbooks/prereg.yml
anskip playbooks/websub.yml
anskip playbooks/regproc.yml
anskip playbooks/ida.yml
anskip playbooks/idrepo.yml
anskip playbooks/pms.yml
anskip playbooks/resident.yml
anskip playbooks/admin.yml
anskip playbooks/print.yml
anskip playbooks/mockabis.yml
# Regclient downloader
anskip playbooks/reg-client-downloader.yml
