
%Lower bound Results for n = 10, p = [0.5, 1], W = 10:10:70, I = 1:5

minVal = zeros(2,length(W));
maxVal = zeros(2,length(W));

for i = 1:length(W)
    min1 = inf;
    min2 = inf;
    for j = 1:length(Inst)
        if(min(values(1,1,i,j,:,1))/values(1,1,i,j,1,2) < min1)
            min1 = min(values(1,1,i,j,:,1))/values(1,1,i,j,1,2);
        end
        if(min(values(1,2,i,j,:,1))/values(1,2,i,j,1,2) < min2)
            min2 = min(values(1,2,i,j,:,1))/values(1,2,i,j,1,2);
        end
    end
    minVal(1,i) = min1;
    minVal(2,i) = min2;
end


figure(1)
hold on
semilogy(W, minVal(1,:))
semilogy(W, minVal(2,:))
legend("Lower Bound for p = 0.5", "Lower Bound for p = 1.0")
xlabel("Max Weight")
ylabel("Approximation Ratio")
hold off

