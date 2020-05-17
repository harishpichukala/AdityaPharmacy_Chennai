CREATE TRIGGER testTrigger ON test1
FOR INSERT
AS

INSERT INTO test 
    (id,name,status)
    SELECT
        id,name,status
        FROM inserted

go