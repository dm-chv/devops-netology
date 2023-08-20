# Домашнее задание к занятию 5 «Тестирование roles»

### Molecule

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.

![screen](/screen/8-ansible-05-m-1.png)

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

<i>Добавил Centos 7 and Ubuntu, отредактировал таску для скачивания и установки пакетов deb и rpm
![screen](/screen/8-ansible-05-m-2.png)

4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

![screen](/screen/8-ansible-05-m-3.png) 

6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

<i>Добавлен тег <b>[08-ansible-test-1.0.0](https://github.com/dm-chv/mnt-homeworks/tree/9474c971348429cc69d13dc71d4258234012890b/08-ansible-02-playbook/playbook/roles/vector)</b></i>

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
<i>Вывод я конечно посмотрел, но выполняется всё с ошибками, предполагаю из-за того, что софт используем старинный. логика понятна</i>

![screen](/screen/8-ansible-05-m-4.png)

4. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

![screen](/screen/8-ansible-05-m-5.png)

5. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
6. Запустите команду `tox`. Убедитесь, что всё отработало успешно.

в докере хоть убейте не работает...в вопросах и ответах увидел, что докер не надо использовать...

<details>
<summary>molecule test -s podman</summary>
<code>
pixel@ubu:~/netology/CI/mnt-homeworks/08-ansible-02-playbook/playbook/roles/vector$ molecule test -s podman
INFO     podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/pixel/.cache/ansible-compat/b0d51c/modules:/home/pixel/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/pixel/.cache/ansible-compat/b0d51c/collections:/home/pixel/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/pixel/.cache/ansible-compat/b0d51c/roles:/home/pixel/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > dependency
INFO     Running from /home/pixel/netology/CI/mnt-homeworks/08-ansible-02-playbook/playbook/roles/vector : ansible-galaxy collection install -vvv containers.podman:>=1.7.0
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running podman > lint
INFO     Lint is disabled.
INFO     Running podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Get passwd entries for USER env] *****************************************
ok: [localhost]

TASK [Get shell async_dir] *****************************************************
ok: [localhost]

TASK [Set async_dir for HOME env] **********************************************
skipping: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'instance', 'pre_build_image': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j682241342515.45333', 'results_file': '/home/pixel/.ansible_async/j682241342515.45333', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

TASK [Delete podman network dedicated to this scenario] ************************
skipping: [localhost] => (item=instance: None specified) 
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=2    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running podman > syntax

playbook: /home/pixel/netology/CI/mnt-homeworks/08-ansible-02-playbook/playbook/roles/vector/molecule/podman/converge.yml
INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [Get podman executable path] **********************************************
fatal: [localhost]: FAILED! => {"changed": false, "cmd": "command -v podman", "delta": "0:00:00.003679", "end": "2023-08-21 00:07:03.092515", "msg": "non-zero return code", "rc": 127, "start": "2023-08-21 00:07:03.088836", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************
localhost                  : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/home/pixel/.cache/molecule/vector/podman/inventory', '--skip-tags', 'molecule-notest,notest', '/home/pixel/.local/lib/python3.10/site-packages/molecule_plugins/podman/playbooks/create.yml']
WARNING  An error occurred during the test sequence action: 'create'. Cleaning up.
INFO     Running podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Get passwd entries for USER env] *****************************************
ok: [localhost]

TASK [Get shell async_dir] *****************************************************
ok: [localhost]

TASK [Set async_dir for HOME env] **********************************************
skipping: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'instance', 'pre_build_image': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j73256804913.45495', 'results_file': '/home/pixel/.ansible_async/j73256804913.45495', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

TASK [Delete podman network dedicated to this scenario] ************************
skipping: [localhost] => (item=instance: None specified) 
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=2    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
</code>
</details>

7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.  
  
<i>Добавлен тег <b>[08-ansible-test-1.1.0](https://github.com/dm-chv/mnt-homeworks/tree/MNT-video/08-ansible-02-playbook/playbook/roles/vector)</b></i>  
После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.
