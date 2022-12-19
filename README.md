Аутистские скрипты, которые пишутся раз в десяток лет




Список подключений:
SELECT pid FROM pg_stat_activity WHERE datname = 'ИМЯ БАЗЫ';

Сброс всех подключений к базе, кроме текущего:
SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'database_name'
    ;


Обрезать "расширение" файла. Единственная проблема, при большом количесвте строк, выводит их в 1 столбец:
awk -F'[/.]' '{print $(NF-1)}'

https://andreyex.ru/linux/komandy-linux-i-komandy-shell/ispolzovanie-komandy-basename-v-bash-scripts/

xargs
