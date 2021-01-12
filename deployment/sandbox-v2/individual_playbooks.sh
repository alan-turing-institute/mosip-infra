#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/console.yml
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/coredns.yml
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml palybooks/nginx.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/nfs.yml
# MZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzcluster.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mz-nfs-provisioner.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzmonitoring.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/taints.yml # At this point we apply any taints for MOSIP pods. 
# DMZ cluster
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzcluster.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmz-nfs-provisioner.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzmonitoring.yml
# Non-MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/postgres.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/keycloak.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mzclamav.yml  # Each zone has it's own clamav
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/dmzclamav.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/activemq.yml
#ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mock-biosdk.yml    #TODO
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/minio.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/artifactory.yml
# MOSIP modules
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/config-server.yml    
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/kernel.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/packetmanager.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/datashare.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/prereg.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/websub.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/regproc.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/ida.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/idrepo.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/pms.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/resident.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/admin.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/print.yml
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/mockabis.yml
# Regclient downloader
ansible-playbook -i hosts.ini --vault-password-file ./vault_default.txt -e @secrets.yml playbooks/reg-client-downloader.yml
