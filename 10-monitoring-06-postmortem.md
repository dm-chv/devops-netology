###  Постмортем на основе реального сбоя системы GitHub в 2018 году.

| Событие                    | Действие                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Краткое описание инцидента | В 22:52 (21.10) по UTC на нескольких сервисах GitHub.com пострадали несколько сетевых разделов и последующим сбоем базы данных, что привело к появлению непоследовательной информации на сайте GitHub.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Предшествующие события     | плановые работы по техническому обслуживанию по замене неисправного оптического оборудования 100G                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Причина инцидента          | Соединение между сетевыми узлами было восстановлено за 43 секунды, но этот кратковременный сбой вызвал цепочку событий, которые привели к ухудшению качества обслуживания на 24 часа и 11 минут.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Воздействие                | Инцидент привел к ухудшению качества обслуживания на 24 часа и 11 минут. Этот инцидент затронул несколько внутренних систем, в результате чего GitHub отображал устаревшую и непоследовательную информацию.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Обнаружение                | Системы мониторинга начали генерировать оповещения, указывающие на многочисленные сбои в системах. В это время несколько инженеров отвечали и работали над сортировкой входящих уведомлений. К 23:02 UTC инженеры группы быстрого реагирования определили, что топологии многочисленных кластеров баз данных находятся в неожиданном состоянии.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Реакция                    | * заблокировали внутренние инструменты развертывания<br/> * группа реагирования перевела сайт в желтый статус <br/> * В 23:11 UTC подключился координатор инцидентов и через две минуты изменил статус решения на красный.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Восстановление             | * 2018 22 октября 00:41 UTC К этому времени был начат процесс резервного копирования для всех затронутых кластеров MySQL <br/> * в 06:51 начали репликацию новых данных с западного побережья. <br/> * команды определили способы восстановления непосредственно с Западного побережья, чтобы преодолеть ограничения пропускной способности,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Таймлайн                   | * 2018 October 21 22:52 UTC: в связи с кратковременным разрывом сети - Серверы баз данных в ЦОД на восточном побережье США содержали короткий период записей, которые не были реплицированы на объект на западном побережье США.<br/> * 2018 October 21 22:54 UTC: системы мониторинга начали генерировать оповещения, указывающие на многочисленные сбои<br/> * 2018 October 21 23:07 UTC: группа реагирования решила вручную заблокировать внутренние инструменты развертывания, <br/> * 2018 October 21 23:13 UTC: вызваны дополнительные инженеры из группы разработки баз данных GitHub<br/> * 2018 October 21 23:19 UTC: приостановили доставку веб-перехватчиков и сборку страниц GitHub<br/> * 2018 October 22 00:05 UTC: инженеры начали разработку плана по устранению несоответствий данных и реализации процедур аварийного переключения для MySQL.<br/> * 2018 October 22 00:41 UTC: начат процесс восстановления из резервных копий для всех затронутых кластеров MySQL<br/> * 2018 October 22 06:51 UTC: несколько кластеров завершили восстановление из резервных копий в ЦОД на восточном побережье США и начали репликацию новых данных с западного побережья.<br/> * 2018 October 22 07:46 UTC: GitHub опубликовал сообщение в блоге о инциденте<br/> * 2018 October 22 11:12 UTC: все первичные базы данных снова установлены на восточном побережье США. В результате сайт стал гораздо более отзывчивым.<br/> * 2018 October 22 13:15 UTC: приближались к пиковой нагрузке трафика на GitHub.com, в следствии чего увеличилась задержка репликации БД.<br/> * 2018 October 22 16:24 UTC: реплики были синхронизированы, команда инженеров выполнили переход на исходную топологию.<br/> * 2018 October 22 16:45 UTC: приостановили обработку и внесли изменения, чтобы на время увеличить TTL событий, которые пережили внутренний срок жизни и были удалены.<br/> * 2018 October 22 23:03 UTC: все ожидающие сборки веб-перехватчиков и страниц были обработаны, а целостность и правильная работа всех систем подтверждены |
| Последующие действия       | * Настройте конфигурацию Orchestrator, чтобы предотвратить распространение основных баз данных за пределы региональных границ<br/> * ускорили переход на новый механизм отчетности о статусе, который предоставит нам более обширную площадку для обсуждения активных инцидентов более четким и понятным языком <br/> * поддержка резервирования N+1 на уровне объекта. Цель этой работы — выдержать полный отказ одного центра обработки данных без воздействия на пользователя. <br/> * GitHub займёт более активную позицию при тестированию сценариев отказа                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |