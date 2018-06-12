function output_code=Huffman_Coding_4x4(input_code)
x=reshape(input_code,1,16);
        k=length(x);
        t=1;
        a(t:k)=0.1;
        b(t:k)=0;
        for i=1 :k
            kk=strfind(a,x(i));
            if isempty(kk)
                a(t)=x(i);
                b(t)=b(t)+1;
                t=t+1;
            else
                t2=kk(1);
                b(t2)=b(t2)+1;
            end
        end
        c = [];
        d = [];
        for i=1:t-1
            c(i)=a(i);
            d(i)=b(i)/k;
        end
        [dict,avglen] = huffmandict(c,d) ;
        B_huffman = huffmanenco(x,dict) ; 
        c=7;
        r=4;
        code=encode(B_huffman',c,r,'hamming');  %汉明码编码
        rcode=decode(code,c,r,'hamming');%汉明码译码
        P = rcode(1:length(B_huffman));
        B_ihuffman= huffmandeco(P,dict); % 对游程编码后的第一分量(0游程的个数)进行 Huffman解码
        output_code=reshape(B_ihuffman,4,4);   %生成16*16矩阵
end