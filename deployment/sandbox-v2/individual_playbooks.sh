ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/console.yml
echo "********** FINISHED CONSOLE 1/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/coredns.yml
echo "********** FINISHED COREDNS 2/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/nginx.yml
echo "********** FINISHED NGINX 3/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/nfs.yml
echo "********** FINISHED NFS 4/33"
# MZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzcluster.yml
echo "********** FINISHED MZCLUSTER 5/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mz-nfs-provisioner.yml
echo "********** FINISHED MZ-NFS_PROVISIONER 6/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzmonitoring.yml
echo "********** FINISHED MZMONITORING 7/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/taints.yml # At this point we apply any taints for MOSIP pods. 
echo "********** FINISHED TAINTS 8/33"
# DMZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzcluster.yml
echo "********** FINISHED DMZCLUSTER 9/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmz-nfs-provisioner.yml
echo "********** FINISHED DMZ-NFS-PROVISIONER 10/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzmonitoring.yml
echo "********** FINISHED DMZMONITORING 11/33"
# Non-MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/postgres.yml
echo "********** FINISHED POSTGRES 12/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/keycloak.yml
echo "********** FINISHED KEYCLOAK 13/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzclamav.yml  # Each zone has it's own clamav
echo "********** FINISHED MZCLAMAV 14/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzclamav.yml
echo "********** FINISHED DMZCLAMAV 15/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/activemq.yml
echo "********** FINISHED ACTIVEMQ 16/33"
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mock-biosdk.yml    #TODO
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/minio.yml
echo "********** FINISHED MINIO 17/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/artifactory.yml
echo "********** FINISHED ARTIFACTORY 18/33"
# MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/config-server.yml    
echo "********** FINISHED CONFIG-SERVER 19/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/kernel.yml
echo "********** FINISHED KERNEL 20/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/packetmanager.yml
echo "********** FINISHED PACKETMANAGER 21/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/datashare.yml
echo "********** FINISHED DATASHARE 22/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/prereg.yml
echo "********** FINISHED PREREG 23/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/websub.yml
echo "********** FINISHED WEBSUB 24/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/regproc.yml
echo "********** FINISHED REGPROC 25/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/ida.yml
echo "********** FINISHED IDA 26/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/idrepo.yml
echo "********** FINISHED IDREPO 27/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/pms.yml
echo "********** FINISHED PMS 28/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/resident.yml
echo "********** FINISHED RESIDENT 29/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/admin.yml
echo "********** FINISHED ADMIN 30/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/print.yml
echo "********** FINISHED PRINT 31/33"
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mock-abis.yml
echo "********** FINISHED MOCKABIS 32/33"
# Regclient downloader
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/reg-client-downloader.yml
echo "********** FINISHED REG-CLIENT-DOWNLOADER 33/33"
