## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
```vector.yml
---
vector_version: 0.22.1
vector_clickhouse_ip: 51.250.66.155
vector_config:
  sources:
    demo_logs:
      type: demo_logs
      format: syslog
  sinks:
    to_clickhouse:
      type: clickhouse
      inputs:
        - demo_logs
      database: "{{ clickhouse_db_name }}"
      endpoint: "http://{{ vector_clickhouse_ip }}:8123"
      table: "{{ clickhouse_table_name }}"
      compression: gzip
      healthcheck: true
      skip_unknown_fields: true
```
```prod.yml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 51.250.66.155
vector:
  hosts:
    vector-01:
      ansible_host: 51.250.66.155
```
```site.yml
- name: Install Vector
  hosts: vector
```
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
 *  Запустил, ошибки только в исходном коде, ругается на "Get clickhouse distrib"
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```OK!
PLAY RECAP ***********************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
vector-01                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```OK!
PLAY RECAP ***********************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```Сделано!
PLAY RECAP ***********************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.