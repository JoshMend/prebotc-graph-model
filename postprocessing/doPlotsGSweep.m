clear all
close all


set(0,'DefaultFigurePaperPositionMode','auto')
set(0,'DefaultAxesFontSize', 18)
set(0,'DefaultAxesFontName','Helvetica')
set(0,'DefaultAxesLineWidth',1);

dopartics = 0;
docombined = 1;
partics = {'er_n300_k1.0_deg_pI0.00_rep1',...
           'er_n300_k1.0_deg_pI0.10_rep1',...
           'er_n300_k1.0_deg_pI0.20_rep1',...
           'er_n300_k1.0_deg_pI0.30_rep1',...
           'er_n300_k1.0_deg_pI1.00_rep1', ...
           'er_n300_k3.0_deg_pI0.00_rep1', ...
           'er_n300_k3.0_deg_pI0.10_rep1', ...
           'er_n300_k3.0_deg_pI0.20_rep1', ...
           'er_n300_k3.0_deg_pI0.30_rep1', ...
           'er_n300_k3.0_deg_pI1.00_rep1', ...
           'er_n300_k2.0_deg_pI0.00_rep1', ...
           'er_n300_k2.0_deg_pI0.10_rep1', ...
           'er_n300_k2.0_deg_pI0.20_rep1', ...
           'er_n300_k2.0_deg_pI0.30_rep1', ...
           'er_n300_k2.0_deg_pI1.00_rep1', ...
           'er_n300_k6.0_deg_pI0.00_rep1', ...
           'er_n300_k6.0_deg_pI0.10_rep1', ...
           'er_n300_k6.0_deg_pI0.20_rep1', ...
           'er_n300_k6.0_deg_pI0.30_rep1', ...
           'er_n300_k6.0_deg_pI1.00_rep1' 
          };
projName = 'random_fine_g_sweep';
opThresh = 0.2;

%% start processing
dataDir = [getenv('HOME') '/work/prebotc/data/', projName]
fn = [dataDir, '/post/collected.mat'];
plotDir = [getenv('HOME') '/work/prebotc/data/', projName, ...
           '/plots'];

if docombined
    load(fn)
    for gEidx = 1:4
        for gIidx = 1:4
            gE = gEs(gEidx);
            gI = gIs(gIidx);
            
            pltGStr = sprintf('gE_%1.1f_gI_%1.1f', gE, gI);

            figure
            myPcolor(X,Y, chiArray(:,:,gEidx, gIidx));
            titlestr=sprintf('synchrony \\chi; gE = %1.1f, gI = %1.1f', ...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle', 'fontsize', 24)
            ylabel('p_I','fontsize', 24)
            caxis([0,1])
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_chi.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, dutyCycle(:,:,gEidx, gIidx))
            titlestr = sprintf('duty cycle; gE = %1.1f, gI = %1.1f', gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle', 'fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_duty_cycle.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, fMax(:,:,gEidx, gIidx))
            titlestr=sprintf('peak frequency (Hz); gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            title('peak frequency (1/s)','fontsize', 32)
            xlabel('\langle k \rangle', 'fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_peak_freq.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, lag(:,:,gEidx, gIidx))
            titlestr=sprintf('dominant period (s); gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle', 'fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_lag.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, muB(:,:,gEidx, gIidx) / 1000)
            titlestr=sprintf(['mean burst duration (s); gE = %1.1f, ' ...
                              'gI = %1.1f'], ...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            title('mean burst duration (s)','fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_mean_burst.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, muIBI(:,:,gEidx, gIidx) / 1000)
            titlestr=sprintf('mean IBI (s); gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_mean_IBI.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, cvIBI(:,:,gEidx, gIidx))
            titlestr=sprintf('CV of IBIs; gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_cv_IBIs.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, cvB(:,:,gEidx, gIidx))
            titlestr=sprintf('CV of burst durations; gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_cv_bursts.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, op_angle_mean(:,:,gEidx, gIidx))
            titlestr=sprintf('mean OP phase; gE = %1.1f, gI = %1.1f',...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_op_angle_mean.eps']
            print('-deps', plt)

            figure
            myPcolor(X,Y, op_angle_std(:,:,gEidx, gIidx))
            titlestr=sprintf(['standard deviation OP phase; gE = ' ...
                              '%1.1f, gI = %1.1f'],...
                             gE,gI);
            title(titlestr, 'fontsize', 32)
            xlabel('\langle k \rangle','fontsize', 24)
            ylabel('p_I','fontsize', 24)
            colorbar
            colormap('gray')
            plt = [plotDir, '/', pltGStr, '_op_angle_std.eps']
            print('-deps', plt)

            close all
        end % gI
    end % gE
end

if dopartics
    %%%%%%%%% plot some trajectories
    idx = 1;
    for partic=partics
        partic = char(partic);
        for gEidx = 1:4
            for gIidx = 1:4
            gE = gEs(gEidx);
            gI = gIs(gIidx);
            pltGStr = sprintf('gE_%1.1f_gI_%1.1f', gE, gI);
            fn1 = [dataDir, '/output/', partic, '_', pltGStr, '.mat'];
            fn2 = [dataDir, '/post/', partic, '_', pltGStr, '_post.mat'];

            A = load(fn1, 'vTypes');
            vTypes = A.vTypes;
            clear A
            [Y,I] = sort(vTypes);

            
            B = load(fn2);
            trans = 12;
            binWidth = double( max(diff(B.bins)) ) / 1000;
            thebins = double( B.bins(trans:end) )/1000;
            butterIntBin = B.butter_int_bin(trans:end);
            binCt = B.spike_mat_bin(:,trans:end);
            ops = B.ops;
            opAngle = angle(ops);
            opAbs = abs(ops);
            peaklocs = B.pop_burst_peak;
            maxindex = length(B.bins)-trans
            peaklocs(peaklocs < trans | peaklocs > maxindex) = [];
            peaklocs = peaklocs - trans + 2; % +1 for trans, +1 for
                                             % python 0-indexing
            
            figure
            set(gcf, 'position', [1118, 727, 2675, 500])
            %% subplot 1
            h1 = subplot(2,1,1);
            axis(h1)
            plot(thebins, butterIntBin, 'k-')
            hold on
            plot(thebins(peaklocs), butterIntBin(peaklocs), 'ko')
            ylabel('\int preBot (Hz/neuron)', 'fontsize', 20)
            tmp = get(gca, 'ylim');
            axis tight
            set(h1, 'ylim', [0, tmp(2)]);
            %% subplot 2
            h2 = subplot(2,1,2);
            axis(h2)
            imagesc(thebins, 1:size(binCt,1), binCt(I,:));
            xlabel('t (s)', 'fontsize', 20)
            colormap(flipud(colormap('gray')))
            set(h2, 'xticklabel', get(h1, 'xticklabel'))
            %spy(binCt(I,:), 'k', 1)
            %xlabel(['time bin (' num2str(binWidth*1000) ' ms)'])
            ylabel('sorted neurons', 'fontsize', 20)
            %% finalize and print
            set(h2, 'xtick', get(h1,'xtick'))
            set(h2, 'xticklabel', get(h1,'xticklabel'))
            %plt = [plotDir, '/ts_raster.eps']
            %print('-deps', plt)
            plt = [plotDir, '/ts_combined_' partic '.eps']
            print('-deps', plt)
            %% order parameter plot
            figure
            plot(opAngle, opAbs, 'k.')
            xlabel('angle (radians)')
            ylabel('magnitude')
            hline(opThresh, 'k--')
            ylim([0, 1])
            xlim([-pi, pi])
            title('neuron order parameters')
            plt = [plotDir, '/op_' partic '.eps']
            print('-deps', plt)

            close all
            end
        end
    end
end