

% Grab keys for the sessions of interest
% Here getting Leo's "ClassDiscrimination" experiment June and onward
keys = fetch(acq.Sessions('session_datetime like "2009-09-22%"',acq.Subjects('subject_name = "Woody"')));
electrodes = fetch(detect.Electrodes(keys(1))); % this will grab 96 electrodes for session_num

%% Leo's keys
leo = fetch(acq.Sessions('session_datetime > "2010"','subject_id = 3',acq.Stimulation('exp_type like "ClassDisc%"')));
tobesorted=fetch(detect.Electrodes(leo) & sort.KalmanAutomatic)

%%
%now create MoKsmInterface object for this

for ind = 1:100
numComponent = 8;
% done with following params
% params.ClusterCost = 0.0023;%0.0023;
% params.Df = 5;
% params.CovRidge = 1.5;%%1.5;
% params.DriftRate = 300 / 3600 / 1000;
% params.DTmu = 100 * 1000;
% params.Tolerance = 0.0005;
% params.Verbose = true;
%
%
% good ones thus far
% good separation: 2, 3, 8, 31*, 35*(sudden change),40!*, 79*, 82, 91
% (nicely done), 
%
% too much sepration on: 5, 13, 15, 16, 17!, 19, 20, 23*, 24, 32*, 36?*,
% 41, 44*, 51*, 58* (looks pretty good but too much?), 60, 61?, 76* (too
% aligned), 83, 87*, 88*(many clouds), 89* (a lot of clusters formed), 90,
% 92, 94, 
% 
% questionable: 7, 30, 34*, 84*
%
% underseparated? : 42, 86*, 95, 96
%
% trivial fit: 6, 12, 18, 21, 22, 25, 27, 28, 29, 33, 46, 48, 49, 53, 54,
% 56, 57, 63, 64, 65, 66, 68, 69, 71, 72*(decreasing variance), 73, 74,
% 75, 78, 80, 81, 85, 93, 
%
% obvious fit: 10, 11, 26, 37, 38, 39*, 43, 45, 47, 50, 52, 55, 62*, 70,
% 77, 
%
% oscillatory noise: 9, 14, 59, 
% very strong noise! : 67*, 
% good electrodes to look at:


%model = MoKsmInterface(electrodes(ind));
model = MoKsmInterface(tobesorted(ind));

model = getFeatures(model, 'PCA', numComponent);
model.Features.data = model.Features.data * 10;
% Set up model parameters
params = model.params;

% Set up MoKsm parametesr
switch(numComponent)
    case 3
        params.ClusterCost = 0;%0.0065;%0.0023;
        params.Df = 9;
        params.CovRidge = 1.5;%%1.5;
        params.DriftRate = 300 / 3600 / 1000;
        params.DTmu = 100 * 1000;
        params.Tolerance = 0.0001;%0.0005;
        params.Verbose = true;
    case 5
        params.ClusterCost = 0.0040;%0.0023;
        params.Df = 8;
        params.CovRidge = 1.5;%%1.5;
        params.DriftRate = 300 / 3600 / 1000;
        params.DTmu = 100 * 1000;
        params.Tolerance = 0.0001;%0.0005;
        params.Verbose = true;
    case 7
        params.ClusterCost = 0.004; %0.0065;%0.0023;
        params.Df = 7;
        params.CovRidge = 1.5;%%1.5;
        params.DriftRate = 300 / 3600 / 1000;
        params.DTmu = 100 * 1000;
        params.Tolerance = 0.0001;%0.0005;
        params.Verbose = true;
    case 8
        fprintf('Now in case 8')
        params.ClusterCost = 0.0038;%0.0030 %0.0065;%0.0023;
        params.Df = 8;
        params.CovRidge = 0.15;
        params.DriftRate = 30 / 3600 / 1000;
        params.DTmu = 100 * 1000;
        params.Tolerance = 0.00005;
        params.Verbose = true;
end
fprintf('assigning new param values\n')
model.params = params;

% 
fitted = fit(model);

m = ManualClustering(fitted);

%pause()
end