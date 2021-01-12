ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/console.yml
echo "FINISHED CONSOLE 1/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/coredns.yml
echo "FINISHED COREDNS 2/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml palybooks/nginx.yml
echo "FINISHED NGINX 3/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/nfs.yml
echo "FINISHED NFS 4/32"
# MZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzcluster.yml
echo "FINISHED MZCLUSTER 5/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mz-nfs-provisioner.yml
echo "FINISHED MZ-NFS_PROVISIONER 6/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzmonitoring.yml
echo "FINISHED MZMONITORING 7/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/taints.yml # At this point we apply any taints for MOSIP pods. 
echo "FINISHED TAINTS 8/32"
# DMZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzcluster.yml
echo "FINISHED DMZCLUSTER 9/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmz-nfs-provisioner.yml
echo "FINISHED DMZ-NFS-PROVISIONER 10/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzmonitoring.yml
echo "FINISHED DMZMONITORING 11/32"
# Non-MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/postgres.yml
echo "FINISHED POSTGRES 12/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/keycloak.yml
echo "FINISHED KEYCLOAK 13/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzclamav.yml  # Each zone has it's own clamav
echo "FINISHED MZCLAMAV 14/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzclamav.yml
echo "FINISHED DMZCLAMAV 15/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/activemq.yml
echo "FINISHED ACTIVEMQ 16/32"
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mock-biosdk.yml    #TODO
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/minio.yml
echo "FINISHED MINIO 17/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/artifactory.yml
echo "FINISHED ARTIFACTORY 18/32"
# MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/config-server.yml    
echo "FINISHED CONFIG-SERVER 19/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/kernel.yml
echo "FINISHED KERNEL 20/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/packetmanager.yml
echo "FINISHED PACKETMANAGER 21/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/datashare.yml
echo "FINISHED DATASHARE 22/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/prereg.yml
echo "FINISHED PREREG 23/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/websub.yml
echo "FINISHED WEBSUB 24/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/regproc.yml
echo "FINISHED REGPROC 25/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/ida.yml
echo "FINISHED IDA 26/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/idrepo.yml
echo "FINISHED IDREPO 27/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/pms.yml
echo "FINISHED PMS 28/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/resident.yml
echo "FINISHED RESIDENT 29/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/admin.yml
echo "FINISHED ADMIN 30/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/print.yml
echo "FINISHED PRINT 31/32"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mockabis.yml
echo "FINISHED MOCKABIS 31/32"
# Regclient downloader
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/reg-client-downloader.yml
echo "FINISHED REG-CLIENT-DOWNLOADER 32/32"
