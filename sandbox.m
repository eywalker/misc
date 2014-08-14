fitResults = [sessionData.simpleFitResults];
allCS = [fitResults.cvContrast];
all_contrast = [allCS.contrast];
uniqCont=unique(all_contrast);
cts=arrayfun(@(x) sum(all_contrast==x), uniqCont);


%%
idxX=find(all_contrast <= 0.3);
ori_adj = [];


for idx=idxX
    allDataX=[allCS(idx).dataSet];
    ori = [allDataX.stimulus];
    L = [allDataX.likelihood];
    resp = [allDataX.classResp];
    respA = strcmp(resp,'A');

    % Analyze overall decision boundary
    binEdges = 230:1:310;

    [p_all,~,~,binc] = nanBinnedStats(ori, respA, binEdges);
    p_all(isnan(p_all))=0;
    %plot(binc, p_all);
    f=fit(binc', p_all, 'gauss2');
    x = linspace(240,300,3000);
    y = f(x);
    left = find(x<270);
    right = find(x>=270);
    [~,pos]=min(abs(y(left)-0.5));
    left_thr = x(left(pos));
    [~,pos]=min(abs(y(right)-0.5));
    right_thr = x(right(pos));

    avg_thr = (right_thr - left_thr)/2;
    title(sprintf('Threshold = %f', avg_thr));
    hold on;
    %plot(f, binc,p_all);


    % fold over the orientation
    pos = (ori > 270);
    ori(pos) = 540 - ori(pos);
    ori = ori - 270 + avg_thr;

    ori_adj = [ori_adj ori];
end



allDataX=[allCS(idxX).dataSet];
ori = [allDataX.stimulus];
L = [allDataX.likelihood];
resp = [allDataX.classResp];
respA = strcmp(resp,'A');
decodeOri = allDataX(1).decodeOri;
[Lm, Ls] = ClassifierModel.getMeanStd(decodeOri, L);

dOri = Lm - ori;

low_v = prctile(Ls, 5);
high_v = prctile(Ls, 95);
lows = Ls < low_v;
highs = Ls >= high_v;
mids = Ls < high_v & Ls >= low_v;
%%
binEdges = -100:3:100;
length(binEdges)
[p_high,~,ct_high,binc] = nanBinnedStats(ori_adj(highs),respA(highs),binEdges);
vd_high = var(dOri(highs));
%[p_mid,~,~,binc] = nanBinnedStats(ori(mids),respA(mids),binEdges);
[p_low,~,ct_low,binc] = nanBinnedStats(ori_adj(lows), respA(lows), binEdges);
vd_low = var(dOri(lows));
figure;
hold on;
plot(binc, p_high, 'r');
%plot(binc, p_mid, 'g');
plot(binc, p_low, 'b')
