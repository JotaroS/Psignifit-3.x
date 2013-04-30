function s_clean = psistriperrors ( s )
% s = psistriperrors ( s )
%
% Strips error messages that are not from psignifit

psignifitlinestarts = {'results','-','1','2','3','4','5','6','7','8','9','0','NaN'};
s_clean = '';

delim = sprintf ( '\n' );
delimidx = find ( s==delim );
delimidx = [0, delimidx, length(s)+1];
for i = 1:length(delimidx)-1;
    start = delimidx(i) + 1;
    stop  = delimidx(i+1) - 1;
    thisline = s ( start:stop );
    for ci = 1:length(psignifitlinestarts);
        cmp = psignifitlinestarts(ci);
        if strncmp(thisline,cmp,length(cmp));
            s_clean = sprintf ( '%s\n%s', s_clean, thisline );
            break
        end
    end
end
