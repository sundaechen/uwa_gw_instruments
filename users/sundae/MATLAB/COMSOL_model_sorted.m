
model_name = 'cantilever_catflap_test.mph';
model_path = 'C:\Users\Xu\Desktop';

%% import comsol package
import com.comsol.model.*
import com.comsol.model.util.*

%% create COMSOL model and save
model = ModelUtil.create('Model');

model.modelPath(model_path);
model.name(model_name);

model.mphsave(strcat(model_path,'\', model_name));

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev1').set('expr', 'solid.freq');

%% set parameters 
model.param.set('w', '100[um]');
model.param.set('l', '200[um]');
model.param.set('t', '6[um]');
model.param.set('t_hinge', '5[um]');
model.param.set('l_hinge', '10[um]');
model.param.set('w_hinge', '10[um]');
model.param.set('p_hinge', '10[um]');

%% create component 1 with tag 'comp1'
model.modelNode.create('comp1');

%% create 

