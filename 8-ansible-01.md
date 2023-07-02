### Основное зщадание
1. Попробуйте запустить playbook на окружении из test.yml, зафиксируйте значение, которое имеет факт some_fact для указанного хоста при выполнении playbook.
```commandline
ok: [localhost] => {
    "msg": 12
}
```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на all default fact.
```commandline
ok: [localhost] => {
    "msg": "all default fact"
} 
```
 
3. Воспользуйтесь подготовленным (используется docker) или создайте собственное окружение для проведения дальнейших испытаний.
```commandline
Done!
```
4. Проведите запуск playbook на окружении из prod.yml. Зафиксируйте полученные значения some_fact для каждого из managed host.
```commandline
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}
```
5. Добавьте факты в group_vars каждой из групп хостов так, чтобы для some_fact получились значения: для deb — deb default fact, для el — el default fact.
6. Повторите запуск playbook на окружении prod.yml. Убедитесь, что выдаются корректные значения для всех хостов.
```commandline
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
```
7. При помощи ansible-vault зашифруйте факты в group_vars/deb и group_vars/el с паролем netology.
8. Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь в работоспособности.
```commandline
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] *******************************************
```
9. Посмотрите при помощи ansible-doc список плагинов для подключения. Выберите подходящий для работы на control node.
```commandline
pixel@Yoga:~/Документы/netology/CI/mnt-homeworks/08-ansible-01-base/playbook$ ansible-doc -t connection -l
ansible.builtin.local          execute on controller                                                                              
ansible.builtin.paramiko_ssh   Run tasks via python ssh (paramiko)                                                                
ansible.builtin.psrp           Run tasks over Microsoft PowerShell Remoting Protocol                                              
ansible.builtin.ssh            connect via SSH client binary                                                                      
ansible.builtin.winrm          Run tasks over Microsoft's WinRM                                                                   
ansible.netcommon.grpc         Provides a persistent connection using the gRPC protocol                                           
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                   
ansible.netcommon.libssh       Run tasks using libssh for ssh connection                                                          
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                        
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                               
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                        
community.aws.aws_ssm          connect to EC2 instances via AWS Systems Manager                                                   
community.docker.docker        Run tasks in docker containers                                                                     
community.docker.docker_api    Run tasks in docker containers                                                                     
community.docker.nsenter       execute on host running controller container                                                       
community.general.chroot       Interact with local chroot                                                                         
community.general.funcd        Use funcd to connect to target                                                                     
community.general.iocage       Run tasks in iocage jails                                                                          
community.general.jail         Run tasks in jails                                                                                 
community.general.lxc          Run tasks in lxc containers via lxc python library                                                 
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                            
community.general.qubes        Interact with an existing QubesOS AppVM                                                            
community.general.saltstack    Allow ansible to piggyback on salt minions                                                         
community.general.zone         Run tasks in a zone instance                                                                       
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                            
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                         
community.okd.oc               Execute tasks in pods running on OpenShift                                                         
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                         
containers.podman.buildah      Interact with an existing buildah container                                                        
containers.podman.podman       Interact with an existing podman container                                                         
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes    
```
10. В prod.yml добавьте новую группу хостов с именем local, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь, что факты some_fact для каждого из хостов определены из верных group_vars.
```commandline
TASK [Print fact] ****************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [local] => {
    "msg": "all default fact"
}
```
12. Заполните README.md ответами на вопросы. Сделайте git push в ветку master. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым playbook и заполненным README.md.