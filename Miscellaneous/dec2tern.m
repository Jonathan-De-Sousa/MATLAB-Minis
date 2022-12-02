function T=dec2tern(N)
%dec2ten: Converts decimal integer to its ternary representation
%dec2bin(D) returns the ternary representation of D as a character vector.
%D must be a non-negative integer.
%Input:     N - decimal integer in numeric data type 
%Output:    T - ternary equivalent of N in character vector data type

%Set initial value for division quotient and counter respectively
Q=N;
count=0;

%Calculate size of T
sizeT=floor((log(N)/log(3))+1);

%Convert N to ternary
while Q>0
    remainder=mod(Q,3);
    T(sizeT-count)=remainder;
    Q=floor(Q/3);
    count=count+1;
end



