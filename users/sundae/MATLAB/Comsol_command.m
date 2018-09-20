mphdoc %% help for COMSOL livelink to Matlab 
% load Comsol model
model = mphload('C:\Users\Xu\Desktop\cantilever_catflap v2.mph'); 
expr = mphgetexpressions(model.param); % export parameters
model.mesh.run; % create mesh
mphmesh(model) % Plot a mesh in a MATLAB figure
mphmeshstats(model) %Return mesh statistics and mesh data information
mphmesh(model) % plot mesh in matlab

% To generate the default solver sequence associated with the physics 
% solved in the model and compute the solution
model.study('std1').run

model.param.set('w','20[um]') % change the parameter value

mphsearch(model) % open GUI for searching expressions in the COMSOL Multiphysics model object

%% create a parametric sweep
% model.study('std1').feature.create('w_hinge_sweep','Parametric')

%% study
model.study('std1').feature('eig').set('neigs', '30'); % set desired no. of frequencies 


%% results
model.result.create('pg3', 1);

model.result('pg2').set('data', 'dset1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.disp'});
model.result('pg2').name('Mode Shape (solid)');
model.result('pg2').feature('surf1').feature.create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field (Material)');
model.mphplot('pg2')

%% create Global Evaluation and save into a table
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', 'solid.freq');
model.result.numerical('gev1').set('descractive', 'on');
model.result.numerical('gev1').set('descr', 'Frequency (Hz)');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1 {gev1} (solid.freq)');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical('gev1').set('descr', 'Frequency');
data = model.mphtable('tbl1').data;

%% export date
model.result.export.create('data1', 'Data');
model.result.export('data1').setIndex('expr', 'u', 0);
model.result.export('data1').setIndex('expr', 'v', 1);
model.result.export('data1').setIndex('expr', 'w', 2);
model.result.export('data1').set('filename', 'C:\Users\Xu\Desktop\Untitled.txt');
model.result.export('data1').set('resolution', 'finer');
model.result.export('data1').run;