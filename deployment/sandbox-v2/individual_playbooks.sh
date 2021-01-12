ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/console.yml
echo "FINISHED CONSOLE"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/coredns.yml
echo "FINISHED COREDNS"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml palybooks/nginx.yml
echo "FINISHED NGINX"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/nfs.yml
echo "FINISHED NFS"
# MZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzcluster.yml
echo "FINISHED MZCLUSTER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mz-nfs-provisioner.yml
echo "FINISHED MZ-NFS_PROVISIONER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzmonitoring.yml
echo "FINISHED MZMONITORING"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/taints.yml # At this point we apply any taints for MOSIP pods. 
echo "FINISHED TAINTS"
# DMZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzcluster.yml
echo "FINISHED DMZCLUSTER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmz-nfs-provisioner.yml
echo "FINISHED DMZ-NFS-PROVISIONER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzmonitoring.yml
echo "FINISHED DMZMONITORING"
# Non-MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/postgres.yml
echo "FINISHED POSTGRES"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/keycloak.yml
echo "FINISHED KEYCLOAK"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzclamav.yml  # Each zone has it's own clamav
echo "FINISHED MZCLAMAV"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzclamav.yml
echo "FINISHED DMZCLAMAV"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/activemq.yml
echo "FINISHED ACTIVEMQ"
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mock-biosdk.yml    #TODO
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/minio.yml
echo "FINISHED MINIO"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/artifactory.yml
echo "FINISHED ARTIFACTORY"
# MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/config-server.yml    
echo "FINISHED CONFIG-SERVER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/kernel.yml
echo "FINISHED KERNEL"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/packetmanager.yml
echo "FINISHED PACKETMANAGER"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/datashare.yml
echo "FINISHED DATASHARE"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/prereg.yml
echo "FINISHED PREREG"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/websub.yml
echo "FINISHED WEBSUB"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/regproc.yml
echo "FINISHED REGPROC"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/ida.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/idrepo.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/pms.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/resident.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/admin.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/print.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mockabis.yml
# Regclient downloader
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/reg-client-downloader.yml
