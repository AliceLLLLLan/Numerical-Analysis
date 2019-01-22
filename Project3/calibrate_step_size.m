clc
clear
close all
f = @(t,x) [x(2);-sin(x(1))];
h = 0.1;
x0V= 0.5:5;
for kk = 1:2
    h = 0.1^kk;
    figure('position',[200+kk*100 200 600 300]); hold on
    for ii = 1:length(x0V)
        x0 = [x0V(ii) x0V(ii)]';
        [T,X] = ms4(f,0,30,h,x0);
        H = @(x) 1/2.*x(2,:).^2-cos(x(1,:))+cos(x0(1));
        HL = H(X);
        plot(T,HL,'k-');
        xlim([0 30])
        xlabel('t'),ylabel('H')
        set(gca,'FontSize',12)
    end
    title(sprintf('h=%3.3f',h))
    set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
    set(gcf, 'PaperSize', [14 7]); 
    saveas(gcf, sprintf('h=%d.pdf',kk));
end