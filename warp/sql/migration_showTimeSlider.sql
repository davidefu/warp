DO 
$$
DECLARE
    migrationCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO migrationCount FROM public.db_initialized where migrationname = 'ShowTimeSlider';

    IF migrationCount = 0 THEN
        ALTER TABLE public."zone" ADD show_slider bool DEFAULT true NOT NULL;
        ALTER TABLE public."zone" ADD min_time int4 DEFAULT 0 NOT NULL;
        ALTER TABLE public."zone" ADD max_time int4 DEFAULT 86399 NOT NULL;

        INSERT INTO public.db_initialized (migrationname) VALUES('ShowTimeSlider');
       
       raise notice 'migration executed';
    ELSE
       raise notice 'migration already executed';
    END IF;
END;
$$
