function [gen_state, z_prev, u_prev] = init_state_calc(filename)

T = 72;

irgdx('init_expdem_mip.gdx', 'u_s', 'z_s');
irgdx(filename, 'Lu', 'Ld')

numGens = length(Lu) - 2; % number of generators not including buy/sell

z_prev = z_s(1:numGens, T);
u_prev = u_s(1:numGens, T);
gen_state = Lu + Ld; % initial start state

for i = 1:numGens
    for t = 1:T
        if (gen_state(i) < Lu(i))
            gen_state(i) = gen_state(i) + 1;
        elseif ((gen_state(i) == Lu(i)) && (u_s(i, t) == 0))
            gen_state(i) = gen_state(i) + 1;
        elseif ((Lu(i) < gen_state(i)) && (gen_state(i) < (Lu(i) + Ld(i))))
            gen_state(i) = gen_state(i) + 1;
        elseif ((gen_state(i) == (Lu(i) + Ld(i))) && (u_s(i, t) == 1))
            gen_state(i) = 1;
        end
    end
end