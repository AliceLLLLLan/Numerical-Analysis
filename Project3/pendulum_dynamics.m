clc
clear
close all
tVec = 0:0.01:20;
thetaV =[-pi 0.2 0.4 0.6 0.8 pi:pi:5*pi];
% thetaV = pi;
dtheta = 0.5;
h = 0.01;
for ii = 1:length(thetaV)
    theta = thetaV(ii);
    x0 = [theta;theta];
    r = 0;
    A = [0 1;-1 -r];
    f = @(t,x) [x(2);-r*x(2)-sin(x(1))];
    x=solvelinearIVP(A,x0);
    figure('position',[200+100*ii 200 600 300]); 
    hold on
    for jj = 1:length(tVec)
        t = tVec(jj);
        X1(:,jj) = x(t);
    end
    [T,X] = ms4(f,0,20,h,x0);
    plot(real(X1(1,:)),real(X1(2,:)),'k-');
    plot(X(1,:),X(2,:),'r-')
    legend('Linearized','ms4')
    title(sprintf('theta=%3.1f',theta))
    xlabel('\theta')
    ylabel('d\theta')
    set(gca,'FontSize',12)
    set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
    set(gcf, 'PaperSize', [14 7]); 
    saveas(gcf, sprintf('r=4%d.pdf',ii));
end