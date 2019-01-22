clc
clear
close all
thetaV = 0:0.2:pi;
dtheta = 0.1;
rVec = 0:0.2:1;
tVec = 0:0.01:30;

for kk = 1:length(rVec)
    r = rVec(kk);
    figure('position',[100+100*kk 200 600 300]); 
    hold on
    for ii = 1:length(thetaV)
        theta = thetaV(ii); 
        x0 = [theta;dtheta];
        A = [0 1;-1 -r];
        x=solvelinearIVP(A,x0);
        for jj = 1:length(tVec)
            t = tVec(jj);
            X(:,jj) = x(t);
        end
        plot(real(X(1,:)),real(X(2,:)),'k-');
    end
    set(gca,'FontSize',12)
    xlabel('\theta')
    ylabel('d\theta')
    title(sprintf('r=%3.3f',r))
    set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
    set(gcf, 'PaperSize', [14 7]); 
    saveas(gcf, sprintf('r=%d.pdf',kk));

end
