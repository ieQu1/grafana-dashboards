-----------------------------------------------------------------------------------
-- prc table
-----------------------------------------------------------------------------------

create table prc (
    node text not null,
    ts timestamp without time zone not null,
    pid text not null,
    dreductions double precision not null,
    dmemory double precision not null,
    reductions bigint not null,
    memory bigint not null,
    message_queue_len bigint not null,
    current_function text,
    initial_call text,
    registered_name text,
    stack_size bigint,
    heap_size bigint,
    total_heap_size bigint,
    current_stacktrace text,
    group_leader text
) partition by range(ts);

alter table prc owner to system_monitor;
grant insert on table prc to system_monitor;
grant select on table prc to grafana;

-----------------------------------------------------------------------------------
-- app_top table
-----------------------------------------------------------------------------------

create table app_top (
    node text,
    ts timestamp without time zone not null,
    application text,
    red_abs bigint,
    red_rel float,
    memory bigint,
    num_processes integer
) partition by range(ts);

alter table app_top owner to system_monitor;
grant insert on table app_top to system_monitor;
grant select on table app_top to grafana;

-----------------------------------------------------------------------------------
-- fun_top table
-----------------------------------------------------------------------------------

create type fun_type as enum ('initial_call', 'current_function');

create table fun_top (
    node text,
    ts timestamp without time zone not null,
    fun text,
    fun_type fun_type,
    num_processes integer
) partition by range(ts);

alter table fun_top owner to system_monitor;
grant insert on table fun_top to system_monitor;
grant select on table fun_top to grafana;

-----------------------------------------------------------------------------------
-- node_status table
-----------------------------------------------------------------------------------

create table node_status (
    node text not null,
    ts timestamp without time zone not null,
    data text
) partition by range(ts);

alter table node_status owner to system_monitor;
grant delete on table node_status to system_monitor;
grant select on table node_status to system_monitor;
grant insert on table node_status to system_monitor;
grant select on table node_status to grafana;

create index node_status_ts_idx on node_status(ts);

-----------------------------------------------------------------------------------
-- node table
-----------------------------------------------------------------------------------

create table node (
    node text not null primary key
);

alter table node owner to system_monitor;
grant select on table node to system_monitor;
grant insert on table node to system_monitor;
grant select on table node to grafana;

create or replace function update_nodes()
   returns trigger
   language plpgsql as
$$
begin
  insert into node(node) values (NEW.node) on conflict do nothing;
  return null;
end;
$$;

create trigger update_nodes_trigger
       after insert on node_status
       for each row
       execute procedure update_nodes();
