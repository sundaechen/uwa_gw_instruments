% function out = model
%
% Untitled.m
%
% Model exported on Sep 18 2017, 22:31 by COMSOL 4.4.0.150.
clear

model_name = 'catflap_3hinges_basic';
model_path = 'C:\Home\Sundae';
freq_shift = 0;
n_freq = 30;

%%

import com.comsol.model.*
import com.comsol.model.util.*

%% create and save model
model = ModelUtil.create('Model');
model.modelPath(model_path);
model.name(model_name);
model.mphsave(strcat(model_path,'\', model_name,'.mph'));

%%
model.modelNode.create('comp1'); % create component

% set parameters in Global Definitions
model.param.set('w', '50[um]');
model.param.set('l', '50[um]');
model.param.set('t', '6[um]');
model.param.set('t_hinge', '0.5[um]');
model.param.set('l_hinge', '5[um]');
model.param.set('w_hinge', '0.5[um]');
model.param.set('n_hinge', '2');

%% build Gemotry
model.geom.create('geom1', 3); % create geometry

model.geom('geom1').lengthUnit('nm');% change unit to micrometre
% model.geom('geom1').run;
% create Block 1 under Geometry
model.geom('geom1').feature.create('blk1', 'Block');
model.geom('geom1').feature('blk1').setIndex('size', 'w', 0); %Width
model.geom('geom1').feature('blk1').setIndex('size', 't', 1); %Depth
model.geom('geom1').feature('blk1').setIndex('size', 'l', 2); %Height
model.geom('geom1').feature('blk1').setIndex('pos', '0', 0); %
model.geom('geom1').feature('blk1').setIndex('pos', '0', 1);
model.geom('geom1').feature('blk1').setIndex('pos', '0', 2);
% model.geom('geom1').run('blk1');

model.geom('geom1').feature.create('blk2', 'Block');
model.geom('geom1').feature('blk2').setIndex('size', 'w_hinge', 0);
model.geom('geom1').feature('blk2').setIndex('size', 't_hinge', 1);
model.geom('geom1').feature('blk2').setIndex('size', 'l_hinge', 2);
model.geom('geom1').feature('blk2').setIndex('pos', '0', 0);
model.geom('geom1').feature('blk2').setIndex('pos', '0.5*t-0.5*t_hinge', 1);
model.geom('geom1').feature('blk2').setIndex('pos', 'l', 2);
% model.geom('geom1').run('blk2');

model.geom('geom1').feature.create('blk3', 'Block');
model.geom('geom1').feature('blk3').setIndex('size', 'w_hinge', 0);
model.geom('geom1').feature('blk3').setIndex('size', 't_hinge', 1);
model.geom('geom1').feature('blk3').setIndex('size', 'l_hinge', 2);
model.geom('geom1').feature('blk3').setIndex('pos', 'w-w_hinge', 0);
model.geom('geom1').feature('blk3').setIndex('pos', '0.5*t-0.5*t_hinge', 1);
model.geom('geom1').feature('blk3').setIndex('pos', 'l', 2);

blk4 = model.geom('geom1').feature.create('blk4', 'Block');
blk4.setIndex('size', 'w_hinge', 0);
blk4.setIndex('size', 't_hinge', 1);
blk4.setIndex('size', 'l_hinge', 2);
blk4.setIndex('pos', '0.5*(w-w_hinge)', 0);
blk4.setIndex('pos', '0.5*t-0.5*t_hinge', 1);
blk4.setIndex('pos', 'l', 2);
% model.geom('geom1').run('blk3');

% model.geom('geom1').runPre('fin');
model.geom('geom1').run;

%% create material

model.material.create('mat1');
model.material('mat1').name('GaAs coating modified');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '85e9');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.3');
model.material('mat1').propertyGroup('def').set('density', '5000');
model.material('mat1').set('family', 'plastic');

%% boundary conditions
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').feature.create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([8 15 21]);

%% build mesh
model.mesh.create('mesh1', 'geom1');% create mesh
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '20000');
model.mesh('mesh1').feature('size').set('hmin', '20');
model.mesh('mesh1').feature('size').set('hgrad', '1.2');
% % model.mesh('mesh1').run('size');

% ref1 = model.mesh('mesh1').feature().create('ref1','Refine');
% ref1.selection().geom('geom1',1)
% ref1.selection.set([])

model.mesh('mesh1').run;
% model.mphmesh() % plot mesh in Matlab

%% build study
model.study.create('std1');
model.study('std1').feature.create('eig', 'Eigenfrequency');
% model.study('std1').feature('eig').activate('solid', true);

model.study('std1').feature('eig').set('neigs', num2str(n_freq));
model.study('std1').feature('eig').set('shift', num2str(freq_shift));

%% build solver
sol1 = model.sol.create('sol1');
sol1.study('std1');
sol1.feature.create('st1', 'StudyStep');
sol1.feature('st1').set('study', 'std1');
sol1.feature('st1').set('studystep', 'eig');
sol1.feature.create('v1', 'Variables');
sol1.feature('v1').set('control', 'eig');
sol1.feature.create('e1', 'Eigenvalue');
sol1.feature('e1').set('shift', num2str(freq_shift));
sol1.feature('e1').set('neigs', n_freq);
sol1.feature('e1').set('transform', 'eigenfrequency');
sol1.feature('e1').set('control', 'eig');
sol1.attach('std1');
sol1.runAll;

%% create displacement plot
model.result.create('pg1', 3);
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.disp'});
model.result('pg1').name('Mode Shape (solid)');
model.result('pg1').feature('surf1').feature.create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field (Material)');
% plot displacement for mode no.

for i = 1:1 % n_freq
    plot_name = '';
    model.result('pg1').set('looplevel', {num2str(i)});
    model.result('pg1').run;
    model.mphplot('pg1')
    saveas(gca, ['mode_',num2str(i),'.png'])
%     print -f -dpng plot_name
    close()
end
    

%% get resonant frequencies
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', 'solid.freq');
model.result.table.create('tbl1', 'Table');
% model.result.table('tbl1').comments('Global Evaluation 1 {gev1} (solid.freq)');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
freqs = model.mphtable('tbl1').data;

freq_filename = strcat(model_path, '\', model_name, '_freq', '.txt');
fid = fopen(freq_filename,'wt');
fprintf(fid,'%f \n',freqs(:,1));
fclose(fid);
% save(freq_filename,freqs,'-ascii');

%% get displacement
model.result.export.create('data1', 'Data');
model.result.export('data1').setIndex('expr', 'u', 0);
model.result.export('data1').setIndex('expr', 'v', 1);
model.result.export('data1').setIndex('expr', 'w', 2);
model.result.export('data1').set('filename', strcat(folder_name,'deformation','.txt'));
model.result.export('data1').set('sort', 'on');
model.result.export('data1').set('resolution', 'finer');
model.result.export('data1').run;

model.mphsave(strcat(model_path,'\', folder_name,'.mph'));

% out = model;
