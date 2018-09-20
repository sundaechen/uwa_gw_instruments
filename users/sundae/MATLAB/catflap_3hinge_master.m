clear
home_path = 'C:\Home\Sundae';
basic_model_name = 'catflap_3hinges_basic.mph';


w = [50,100,150,200,500,1000];
l = [50,100,150,200,500,1000];

t_hinge = [0.1,0.2,0.5,1,2];
w_hinge = [0.1,0.2,0.5,1,2,5,10];

l_hinge = [1,5,10];

n_freq = 50;
freq_shift = 0;

for wi = 1:size(w,2)
    for thi = 1:size(t_hinge,2)
        for whi = 1:size(w_hinge,2)
            for lhi = 1:size(l_hinge,2)
                                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
                tic
                model = mphload(strcat(home_path,'\',basic_model_name));
                model.param.set('w', strcat(num2str(w(wi)),'[um]'));
                model.param.set('l', strcat(num2str(l(wi)),'[um]'));
                model.param.set('t_hinge', strcat(num2str(t_hinge(thi)),'[um]'));
                model.param.set('w_hinge', strcat(num2str(w_hinge(whi)),'[um]'));
                model.param.set('l_hinge', strcat(num2str(l_hinge(lhi)),'[um]'));
                
                
                folder_name= strcat('catflap_3Hinge',...
                         '_w',num2str(w(wi)),...
                         '_l',num2str(l(wi)),...
                         '_th',num2str(t_hinge(thi)),...
                         '_wh',num2str(w_hinge(whi)),...
                         '_lh',num2str(l_hinge(lhi))...
                         );
                disp(folder_name)
                     
                mkdir(strcat(home_path,'\',folder_name));
                cd(strcat(home_path,'\',folder_name));
                
%                 model.modelPath = strcat(home_path,'\',folder_name);
            
                model.geom('geom1').run;
                model.mesh('mesh1').run;
                
                model.study('std1').feature('eig').set('neigs', num2str(n_freq));
                model.study('std1').feature('eig').set('shift', num2str(freq_shift));
                
                model.sol('sol1').runAll;
                
                for i = 1: 30% n_freq
                    plot_name = '';
                    model.result('pg1').set('looplevel', {num2str(i)});
                    model.result('pg1').run;
                    model.mphplot('pg1')
                    saveas(gca, ['catflap_layout_clamped_mode_',num2str(i),'.png'])
                    close()
                end
                
                %get resonant frequencies
                model.result.numerical('gev1').setResult;
                freqs = model.mphtable('tbl1').data;
                freq_filename = strcat('folder_name','_freq', '.txt');
                fid = fopen(freq_filename,'wt');
                fprintf(fid,'%f \n',freqs(:,1));
                fclose(fid);
                
%                 %get defomation 
%                 model.result.export('data1').setIndex('expr', 'u', 0);
%                 model.result.export('data1').setIndex('expr', 'v', 1);
%                 model.result.export('data1').setIndex('expr', 'w', 2);
%                 model.result.export('data1').set('filename', strcat(folder_name,'deformation','.txt'));
%                 model.result.export('data1').set('sort', 'on');
%                 model.result.export('data1').set('resolution', 'finer');
%                 model.result.export('data1').run;
                
                model.mphsave(strcat(home_path,'\', folder_name,'.mph'));
                toc
%                 clear(model)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
    end
end
     