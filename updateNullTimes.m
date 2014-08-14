keys = fetch(acq.Sessions & 'session_stop_time is NULL');
%%
for k = keys'
    try
        acq.Sessions & k
        
        fprintf('Hmm... weird, did not get an error\n')
    catch
        fprintf('Indeed, got error!\n');
        update(acq.Sessions & k, 'session_stop_time', 0);
    end
end