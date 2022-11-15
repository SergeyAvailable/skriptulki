Скрипты для постгреса



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



