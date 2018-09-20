function out = model
%
% cantilever_catflap_v2_Copy.m
%
% Model exported on Sep 12 2017, 18:32 by COMSOL 4.4.0.150.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Xu\Desktop');
model.name('cantilever_catflap_test.mph');

model.modelNode.create('comp1');

model.geom.create('geom1', 3);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');

model.study.create('std1');
model.study('std1').feature.create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').activate('solid', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').run;

model.material.create('mat1');
model.material('mat1').name('GaAs coating modified');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '85e9');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.3');
model.material('mat1').propertyGroup('def').set('density', '5000');
model.material('mat1').set('family', 'plastic');

model.geom('geom1').feature.create('blk1', 'Block');

model.param.set('w', '100[um]');
model.param.set('l', '200[um]');
model.param.set('t', '6[um]');
model.param.set('t_cut', '5[um]');
model.param.set('l_cut', '10[um]');

model.geom('geom1').feature('blk1').setIndex('size', 'w', 0);
model.geom('geom1').feature('blk1').setIndex('size', 'l', 1);
model.geom('geom1').feature('blk1').setIndex('size', 't', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'l', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').feature('blk1').setIndex('pos', '0.5*w', 0);
model.geom('geom1').run('blk1');
model.geom('geom1').feature('blk1').setIndex('pos', '-0.5*w', 0);
model.geom('geom1').run('blk1');
model.geom('geom1').run('blk1');
model.geom('geom1').feature.create('blk2', 'Block');
model.geom('geom1').feature('blk2').setIndex('size', 'w', 0);
model.geom('geom1').feature('blk2').setIndex('pos', '-0.5*w', 0);
model.geom('geom1').feature('blk2').setIndex('size', 't_cut', 1);
model.geom('geom1').feature('blk2').setIndex('size', 'l_cut', 2);
model.geom('geom1').run('blk2');
model.geom('geom1').feature('blk2').setIndex('pos', 'l-l_cut', 2);
model.geom('geom1').run('blk2');

model.param.set('p_cut', '0[um]');

model.geom('geom1').feature('blk2').setIndex('pos', 'l-l_cut-p_cut', 2);

model.param.set('p_cut', '10[um]');

model.geom('geom1').run('blk2');
model.geom('geom1').feature.create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('solid').feature.create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([7]);

model.study('std1').feature('eig').set('neigs', '30');

model.param.set('t_cut', '5.9[um]');

model.geom('geom1').run('fin');

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').feature.create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').feature.create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').feature.create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('shift', '0');
model.sol('sol1').feature('e1').set('neigs', 30);
model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').attach('std1');

model.result.create('pg1', 3);
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.disp'});
model.result('pg1').name('Mode Shape (solid)');
model.result('pg1').feature('surf1').feature.create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field (Material)');

model.sol('sol1').runAll;

model.result('pg1').run;
model.mphplot('pg1')

model.result('pg1').set('looplevel', {'1'});
model.result('pg1').run;
model.mphplot('pg1')

model.result('pg1').set('looplevel', {'2'});
model.result('pg1').run;
model.mphplot('pg1')

%save model
model.mphsave(strcat(char(model.modelPath),'\', char(model.name));


%% 
% model.result('pg1').run;
% model.result('pg1').set('allowtableupdate', false);
% model.result('pg1').set('title', ['Eigenfrequency=7104.44758 Surface: Total displacement (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)']);
% model.result('pg1').feature('surf1').set('rangeunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
% model.result('pg1').feature('surf1').set('rangecolormin', 0);
% model.result('pg1').feature('surf1').set('rangecolormax', 4513795.490211902);
% model.result('pg1').feature('surf1').set('rangecoloractive', 'off');
% model.result('pg1').feature('surf1').set('rangedatamin', 0);
% model.result('pg1').feature('surf1').set('rangedatamax', 4513795.490211902);
% model.result('pg1').feature('surf1').set('rangedataactive', 'off');
% model.result('pg1').feature('surf1').set('rangeactualminmax', [0 4513795.490211902]);
% model.result('pg1').feature('surf1').feature('def').set('scale', 2.2597390648554092E-6);
% model.result('pg1').feature('surf1').feature('def').set('scaleactive', false);
% model.result('pg1').set('renderdatacached', false);
% model.result('pg1').set('allowtableupdate', true);
% model.result('pg1').set('renderdatacached', true);
% 
% model.study('std1').feature.create('param', 'Parametric');
% model.study('std1').feature('param').setIndex('pname', 'w', 0);
% model.study('std1').feature('param').setIndex('plistarr', '', 0);
% model.study('std1').feature('param').setIndex('pname', 'w', 0);
% model.study('std1').feature('param').setIndex('plistarr', '', 0);
% model.study('std1').feature('param').setIndex('pname', 't_cut', 0);
% model.study('std1').feature('param').setIndex('plistarr', 'range(5,0.1,5.9)', 0);
% model.study('std1').feature('param').setIndex('pname', 'w', 1);
% model.study('std1').feature('param').setIndex('plistarr', '', 1);
% model.study('std1').feature('param').setIndex('pname', 'w', 1);
% model.study('std1').feature('param').setIndex('plistarr', '', 1);
% model.study('std1').feature('param').setIndex('pname', 'p_cut', 1);
% model.study('std1').feature('param').setIndex('plistarr', 'range(0,1,10)', 1);
% model.study('std1').feature('param').setIndex('pname', 'w', 2);
% model.study('std1').feature('param').setIndex('plistarr', '', 2);
% model.study('std1').feature('param').setIndex('pname', 'w', 2);
% model.study('std1').feature('param').setIndex('plistarr', '', 2);
% model.study('std1').feature('param').setIndex('pname', 'l_cut', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(1,49/48,50)', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(1,49/49,50)', 2);
% model.study('std1').feature('param').set('sweeptype', 'filled');
% 
% model.geom('geom1').feature.duplicate('blk3', 'blk2');
% model.geom('geom1').feature.move('blk3', 2);
% 
% model.param.set('w_cut', '10[um]');
% 
% model.geom('geom1').feature('blk3').setIndex('size', 'w_cut', 0);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*(w-w_cut)', 1);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*(w-w_cut)', 0);
% model.geom('geom1').feature('blk3').setIndex('pos', '0', 1);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*w-w_cut', 0);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*w_cut', 0);
% model.geom('geom1').run('blk3');
% model.geom('geom1').feature('blk3').setIndex('size', 't', 1);
% model.geom('geom1').run('blk3');
% model.geom('geom1').feature('dif1').selection('input2').set({'blk2' 'blk3'});
% model.geom('geom1').runPre('fin');
% 
% model.param.remove('w_cut');
% model.param.set('w_hinge', '10[um]');
% 
% model.geom('geom1').feature('blk3').setIndex('size', 'w_hinge', 0);
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*w_hinge', 0);
% model.geom('geom1').run('blk3');
% model.geom('geom1').feature('blk3').setIndex('size', 'w-2*w_hinge', 0);
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*w-w_hinge', 0);
% model.geom('geom1').run('blk3');
% model.geom('geom1').feature('blk3').setIndex('pos', '-0.5*w+w_hinge', 0);
% model.geom('geom1').run('blk3');
% model.geom('geom1').runPre('fin');
% 
% model.study('std1').feature('param').setIndex('pname', 'w', 3);
% model.study('std1').feature('param').setIndex('plistarr', '', 3);
% model.study('std1').feature('param').setIndex('pname', 'w', 3);
% model.study('std1').feature('param').setIndex('plistarr', '', 3);
% model.study('std1').feature('param').setIndex('pname', 'w_hinge', 3);
% model.study('std1').feature('param').setIndex('plistarr', '1,2,5,10,20,50,100', 3);
% model.study('std1').feature('param').setIndex('plistarr', 'range(1,50/10,50)', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(0,50/10,50)', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(0,50/9,50)', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(0,50/10,50)', 2);
% model.study('std1').feature('param').setIndex('plistarr', 'range(0,50/10,50)', 2);
% 
% model.geom('geom1').run('fin');
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% 
% model.batch.create('p1', 'Parametric');
% model.batch('p1').study('std1');
% model.batch('p1').feature.create('so1', 'Solutionseq');
% model.batch('p1').feature('so1').set('seq', 'sol1');
% model.batch('p1').feature('so1').set('store', 'off');
% model.batch('p1').feature('so1').set('clear', 'on');
% model.batch('p1').feature('so1').set('psol', 'none');
% model.batch('p1').set('pname', {'t_cut' 'p_cut' 'l_cut' 'w_hinge'});
% model.batch('p1').set('plistarr', {'range(5,0.1,5.9)' 'range(0,1,10)' 'range(0,50/10,50)' '1,2,5,10,20,50,100'});
% model.batch('p1').set('sweeptype', 'filled');
% model.batch('p1').set('probesel', 'all');
% model.batch('p1').set('probes', {});
% model.batch('p1').set('plot', 'off');
% model.batch('p1').set('err', 'on');
% model.batch('p1').set('pdistrib', 'off');
% model.batch('p1').attach('std1');
% model.batch('p1').set('control', 'param');
% 
% model.sol.create('sol2');
% model.sol('sol2').study('std1');
% model.sol('sol2').name('Parametric 2');
% 
% model.batch('p1').feature('so1').set('psol', 'sol2');
% 
% model.result.create('pg2', 3);
% model.result('pg2').set('data', 'dset2');
% model.result('pg2').feature.create('surf1', 'Surface');
% model.result('pg2').feature('surf1').set('expr', {'solid.disp'});
% model.result('pg2').name('Mode Shape (solid) 1');
% model.result('pg2').feature('surf1').feature.create('def', 'Deform');
% model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
% model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field (Material)');
% 
% model.geom('geom1').run('blk1');
% 
% model.param.set('p_cut', '0[um]');
% 
% model.geom('geom1').run('fin');
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% 
% model.batch('p1').feature.remove('so1');
% model.batch('p1').feature.create('so1', 'Solutionseq');
% model.batch('p1').feature('so1').set('seq', 'sol1');
% model.batch('p1').feature('so1').set('store', 'off');
% model.batch('p1').feature('so1').set('clear', 'on');
% model.batch('p1').feature('so1').set('psol', 'sol2');
% model.batch('p1').set('pname', {'t_cut' 'p_cut' 'l_cut' 'w_hinge'});
% model.batch('p1').set('plistarr', {'range(5,0.1,5.9)' 'range(0,1,10)' 'range(0,50/10,50)' '1,2,5,10,20,50,100'});
% model.batch('p1').set('sweeptype', 'filled');
% model.batch('p1').set('probesel', 'all');
% model.batch('p1').set('probes', {});
% model.batch('p1').set('plot', 'off');
% model.batch('p1').set('err', 'on');
% model.batch('p1').set('pdistrib', 'off');
% model.batch('p1').attach('std1');
% model.batch('p1').set('control', 'param');
% 
% model.geom('geom1').run('blk1');
% 
% model.study('std1').feature('param').setIndex('plistarr', 'range(1,50/10,50)', 2);
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% 
% model.batch('p1').feature.remove('so1');
% model.batch('p1').feature.create('so1', 'Solutionseq');
% model.batch('p1').feature('so1').set('seq', 'sol1');
% model.batch('p1').feature('so1').set('store', 'off');
% model.batch('p1').feature('so1').set('clear', 'on');
% model.batch('p1').feature('so1').set('psol', 'sol2');
% model.batch('p1').set('pname', {'t_cut' 'p_cut' 'l_cut' 'w_hinge'});
% model.batch('p1').set('plistarr', {'range(5,0.1,5.9)' 'range(0,1,10)' 'range(1,50/10,50)' '1,2,5,10,20,50,100'});
% model.batch('p1').set('sweeptype', 'filled');
% model.batch('p1').set('probesel', 'all');
% model.batch('p1').set('probes', {});
% model.batch('p1').set('plot', 'off');
% model.batch('p1').set('err', 'on');
% model.batch('p1').set('pdistrib', 'off');
% model.batch('p1').attach('std1');
% model.batch('p1').set('control', 'param');
% 
% model.geom('geom1').run('blk2');
% 
% model.study('std1').feature('param').setIndex('plistarr', 'range(1,50/10,51)', 2);
% model.study('std1').feature('param').setIndex('plistarr', '1,2,5,10,20,50,100', 2);
% 
% model.name('cantilever_catflap.mph');
% 
% model.study('std1').feature('param').setIndex('plistarr', 'range(5.9)', 0);
% model.study('std1').feature('param').setIndex('plistarr', '5.9', 0);
% model.study('std1').feature('param').setIndex('plistarr', '1,2,5,10,20,50', 1);
% model.study('std1').feature('param').setIndex('plistarr', '1,2,5,10,20', 2);
% model.study('std1').feature('param').setIndex('plistarr', '1,2,5,10,20,50', 3);
% model.study('std1').feature('param').active(false);
% 
% model.param.set('l_cut', '20[um]');
% model.param.set('p_cut', '50[um]');
% model.param.set('w_hinge', '20[um]');
% 
% model.geom('geom1').run;
% model.geom('geom1').run('fin');
% 
% model.mesh('mesh1').run;
% model.mesh('mesh1').automatic(false);
% model.mesh('mesh1').feature('size').set('custom', 'on');
% model.mesh('mesh1').feature('size').set('hmin', '0.02');
% model.mesh('mesh1').run;
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% 
% model.batch.remove('p1');
% 
% model.result('pg1').run;
% model.result('pg2').run;
% model.result('pg2').feature('surf1').set('data', 'dset2');
% model.result('pg2').feature('surf1').set('outersolnum', '1');
% model.result('pg2').run;
% model.result('pg2').feature('surf1').set('data', 'parent');
% model.result('pg2').run;
% model.result('pg2').run;
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% model.sol('sol1').feature('st1').clearXmesh;
% model.sol('sol1').feature('st1').meshextend('dummy_name');
% model.sol('sol1').feature('st1').xmeshInfo;
% model.sol('sol1').feature('st1').clearXmesh;
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% model.sol('sol1').feature('st1').clearXmesh;
% model.sol('sol1').feature('st1').meshextend('dummy_name');
% model.sol('sol1').feature('st1').xmeshInfo;
% model.sol('sol1').feature('st1').clearXmesh;
% 
% model.param.set('t_cut', '5.8[um]');
% model.param.set('l_cut', '4[um]');
% model.param.set('p_cut', '0[um]');
% model.param.set('w_hinge', '0.2[um]');
% model.param.set('w', '150[um]');
% model.param.set('l', '150[um]');
% model.param.set('t', '10[um]');
% 
% model.geom('geom1').run('fin');
% 
% model.study('std1').feature.remove('param');
% 
% model.geom('geom1').run('fin');
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% model.sol('sol1').runAll;
% 
% model.result('pg1').run;
% 
% model.param.set('w_hinge', '0.1[um]');
% model.param.set('t_cut', '9.8[um]');
% 
% model.geom('geom1').run('fin');
% model.geom('geom1').feature('blk2').setIndex('size', 't-t_cut', 1);
% 
% model.param.set('t_cut', '0.2[um]');
% 
% model.geom('geom1').run('fin');
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% model.sol('sol1').runAll;
% 
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'2'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'1'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'2'});
% model.result('pg1').run;
% model.result.export.create('play1', 'Player');
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').run;
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').set('windowtitle', '');
% model.result('pg2').run;
% model.result('pg1').run;
% model.result.export.create('play2', 'Player');
% model.result.export('play2').set('plotgroup', 'pg1');
% model.result.export('play2').set('sweeptype', 'dde');
% model.result.export('play2').set('maxframes', 11);
% model.result.export('play2').set('autoplay', false);
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').run;
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').set('windowtitle', '');
% model.result.export('play2').set('showframe', 0);
% model.result.export('play2').set('stopped', false);
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 1);
% model.result.export('play2').set('lastplaytime', 1.505199472207E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 2);
% model.result.export('play2').set('lastplaytime', 1.505199476289E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 3);
% model.result.export('play2').set('lastplaytime', 1.505199476477E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 4);
% model.result.export('play2').set('lastplaytime', 1.505199476654E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 5);
% model.result.export('play2').set('lastplaytime', 1.50519947687E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 6);
% model.result.export('play2').set('lastplaytime', 1.505199477039E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 7);
% model.result.export('play2').set('lastplaytime', 1.505199477212E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 8);
% model.result.export('play2').set('lastplaytime', 1.505199477387E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 9);
% model.result.export('play2').set('lastplaytime', 1.505199477573E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 10);
% model.result.export('play2').set('lastplaytime', 1.505199477756E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 11);
% model.result.export('play2').set('lastplaytime', 1.505199477931E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', false);
% model.result.export('play2').set('showframe', 0);
% model.result.export('play2').set('stopped', false);
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 1);
% model.result.export('play2').set('lastplaytime', 1.505199481197E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 2);
% model.result.export('play2').set('lastplaytime', 1.505199481353E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 3);
% model.result.export('play2').set('lastplaytime', 1.505199481526E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 4);
% model.result.export('play2').set('lastplaytime', 1.505199481698E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 5);
% model.result.export('play2').set('lastplaytime', 1.505199481863E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 6);
% model.result.export('play2').set('lastplaytime', 1.505199482023E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 7);
% model.result.export('play2').set('lastplaytime', 1.505199482183E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 8);
% model.result.export('play2').set('lastplaytime', 1.50519948233E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 9);
% model.result.export('play2').set('lastplaytime', 1.505199482491E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 10);
% model.result.export('play2').set('lastplaytime', 1.505199482658E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', true);
% model.result.export('play2').set('showframe', 11);
% model.result.export('play2').set('lastplaytime', 1.505199482859E12);
% model.result.export('play2').run;
% model.result('pg1').set('animating', false);
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result.export.create('play3', 'Player');
% model.result.export('play3').set('plotgroup', 'pg1');
% model.result.export('play3').set('sweeptype', 'dde');
% model.result.export('play3').set('maxframes', 11);
% model.result.export('play3').set('autoplay', false);
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').run;
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').set('windowtitle', '');
% model.result.export('play3').set('showframe', 0);
% model.result.export('play3').set('stopped', false);
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 1);
% model.result.export('play3').set('lastplaytime', 1.505199501307E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 2);
% model.result.export('play3').set('lastplaytime', 1.505199505192E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 3);
% model.result.export('play3').set('lastplaytime', 1.505199505352E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 4);
% model.result.export('play3').set('lastplaytime', 1.505199505518E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 5);
% model.result.export('play3').set('lastplaytime', 1.505199505684E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 6);
% model.result.export('play3').set('lastplaytime', 1.505199505853E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 7);
% model.result.export('play3').set('lastplaytime', 1.50519950602E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 8);
% model.result.export('play3').set('lastplaytime', 1.505199506177E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 9);
% model.result.export('play3').set('lastplaytime', 1.505199506352E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 10);
% model.result.export('play3').set('lastplaytime', 1.50519950653E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', true);
% model.result.export('play3').set('showframe', 11);
% model.result.export('play3').set('lastplaytime', 1.505199506712E12);
% model.result.export('play3').run;
% model.result('pg1').set('animating', false);
% model.result('pg2').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg2').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'1'});
% model.result('pg1').run;
% 
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('size', 't-t_pivot', 1);
% 
% model.param.remove('t_cut');
% model.param.set('t_pivot', '0.2[um]');
% 
% model.geom('geom1').run('blk3');
% model.geom('geom1').run('fin');
% model.geom('geom1').feature('blk1').setIndex('size', 'l+l_cut', 2);
% model.geom('geom1').run('blk1');
% model.geom('geom1').feature('blk1').setIndex('pos', '-l', 2);
% model.geom('geom1').run('blk1');
% model.geom('geom1').feature('blk1').setIndex('pos', '0', 2);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature('blk2').setIndex('pos', 'l-p_cut', 2);
% model.geom('geom1').feature('blk3').setIndex('pos', 'l-p_cut', 2);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').feature.duplicate('blk4', 'blk2');
% model.geom('geom1').feature.move('blk4', 2);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('size', '(t-t_pivot)/2', 1);
% model.geom('geom1').feature('blk2').setIndex('pos', '(t-t_pivot)/4', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', '-t/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk4').setIndex('size', '(t-t_pivot)/2', 1);
% 
% model.result('pg2').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'5'});
% model.result('pg1').run;
% model.result.export.create('play4', 'Player');
% model.result.export('play4').set('plotgroup', 'pg1');
% model.result.export('play4').set('sweeptype', 'dde');
% model.result.export('play4').set('maxframes', 11);
% model.result.export('play4').set('autoplay', false);
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').run;
% model.result('pg1').set('window', 'graphics');
% model.result('pg1').set('windowtitle', '');
% model.result.export('play4').set('showframe', 0);
% model.result.export('play4').set('stopped', false);
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 1);
% model.result.export('play4').set('lastplaytime', 1.505200086735E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 2);
% model.result.export('play4').set('lastplaytime', 1.505200090656E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 3);
% model.result.export('play4').set('lastplaytime', 1.505200090828E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 4);
% model.result.export('play4').set('lastplaytime', 1.505200090987E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 5);
% model.result.export('play4').set('lastplaytime', 1.505200091143E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 6);
% model.result.export('play4').set('lastplaytime', 1.505200091372E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 7);
% model.result.export('play4').set('lastplaytime', 1.505200091528E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 8);
% model.result.export('play4').set('lastplaytime', 1.505200091692E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 9);
% model.result.export('play4').set('lastplaytime', 1.505200091865E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 10);
% model.result.export('play4').set('lastplaytime', 1.505200092019E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', true);
% model.result.export('play4').set('showframe', 11);
% model.result.export('play4').set('lastplaytime', 1.505200092247E12);
% model.result.export('play4').run;
% model.result('pg1').set('animating', false);
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'6'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% 
% model.geom('geom1').run('blk4');
% model.geom('geom1').feature('blk4').setIndex('pos', '(t-t_pivot)/2', 1);
% 
% model.param.set('t_pivot', '2[um]');
% model.param.set('w_hinge', '1[um]');
% 
% model.geom('geom1').run('blk4');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', '0', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').run('blk1');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', '0', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('size', '(t-t_pivot)', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('size', '(t-t_pivot)/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_povit', 1);
% model.geom('geom1').run('blk1');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_pivot', 1);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't/2-t_pivot', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_pivot', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_pivot/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't+t_pivot/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_pivot/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't-t_pivot*2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk4').setIndex('pos', '0', 1);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').run('blk4');
% model.geom('geom1').runPre('dif1');
% model.geom('geom1').feature('dif1').selection('input2').set({'blk2' 'blk3' 'blk4'});
% model.geom('geom1').runPre('fin');
% 
% model.param.set('t_pivot', '5[um]');
% 
% model.geom('geom1').run('fin');
% model.geom('geom1').run('blk1');
% model.geom('geom1').run('blk2');
% model.geom('geom1').run('blk4');
% model.geom('geom1').run('blk4');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', '-t_pivot', 1);
% model.geom('geom1').runPre('fin');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', '0', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't/2-t_pivot/2', 1);
% model.geom('geom1').run('blk2');
% 
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'5'});
% model.result('pg1').run;
% 
% model.geom('geom1').run('blk1');
% model.geom('geom1').run('blk2');
% model.geom('geom1').feature('blk2').setIndex('pos', 't/2+t_pivot/2', 1);
% model.geom('geom1').run('blk2');
% model.geom('geom1').run('blk4');
% model.geom('geom1').run('blk3');
% model.geom('geom1').runPre('fin');
% 
% model.param.set('w_hinge', '0.1[um]');
% model.param.set('t_pivot', '0.2[um]');
% 
% model.geom('geom1').run('fin');
% 
% model.sol('sol1').study('std1');
% model.sol('sol1').feature.remove('e1');
% model.sol('sol1').feature.remove('v1');
% model.sol('sol1').feature.remove('st1');
% model.sol('sol1').feature.create('st1', 'StudyStep');
% model.sol('sol1').feature('st1').set('study', 'std1');
% model.sol('sol1').feature('st1').set('studystep', 'eig');
% model.sol('sol1').feature.create('v1', 'Variables');
% model.sol('sol1').feature('v1').set('control', 'eig');
% model.sol('sol1').feature.create('e1', 'Eigenvalue');
% model.sol('sol1').feature('e1').set('shift', '0');
% model.sol('sol1').feature('e1').set('neigs', 30);
% model.sol('sol1').feature('e1').set('transform', 'eigenfrequency');
% model.sol('sol1').feature('e1').set('control', 'eig');
% model.sol('sol1').attach('std1');
% model.sol('sol1').runAll;
% 
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'1'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'2'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'1'});
% model.result('pg1').run;
% model.result('pg2').run;
% model.result.remove('pg2');
% model.result('pg1').run;
% model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', 'solid.freq');
model.result.numerical('gev1').set('descractive', 'on');
model.result.numerical('gev1').set('descr', 'Frequency (Hz)');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1 {gev1} (solid.freq)');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical('gev1').set('descr', 'Frequency');
% model.result.numerical('gev1').set('descractive', 'off');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').appendResult;
% model.result.table.remove('tbl1');
% model.result.table.create('tbl1', 'Table');
% model.result.table('tbl1').comments('Global Evaluation 1 {gev1} (solid.freq)');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').setResult;
% model.result.numerical('gev1').set('expr', '');
% model.result.numerical('gev1').set('descr', ' ');
% model.result.numerical('gev1').set('expr', 'l');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').appendResult;
% model.result.numerical('gev1').set('descr', ' ');
% model.result.numerical('gev1').set('expr', 't');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').appendResult;
% model.result.numerical('gev1').set('descr', ' ');
% model.result.numerical('gev1').set('expr', 'troot.');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').set('expr', 'root.w');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').appendResult;
% model.result.numerical('gev1').set('expr', '');
% model.result.table.remove('tbl1');
% 
% model.param.set('w', '50[um]');
% model.param.set('l', '50[um]');
% model.param.set('t', '6[um]');
% 
% model.result.numerical('gev1').set('expr', 'solid.freq');
% model.result.table.create('tbl1', 'Table');
% model.result.table('tbl1').comments('Global Evaluation 1 {gev1} (solid.freq)');
% model.result.numerical('gev1').set('table', 'tbl1');
% model.result.numerical('gev1').setResult;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'2'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'3'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'4'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'5'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'6'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'7'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'5'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'6'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'7'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'8'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'9'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'10'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'11'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'12'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'13'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'14'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'15'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'16'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'17'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'18'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'19'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'20'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'21'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'22'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'23'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'24'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'25'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'26'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'27'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'28'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'29'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'30'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'9'});
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'8'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'7'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'8'});
% model.result('pg1').run;
% model.result('pg1').set('looplevel', {'9'});
% model.result('pg1').run;
% 
% model.study('std1').feature('eig').set('neigs', '15');
% 
% model.name('cantilever_catflap v2 - Copy.mph');
% model.name('cantilever_catflap_v2-Copy.mph');
% 
out = model;
