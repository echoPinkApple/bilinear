img=imread('test.bmp');
%imshow(img);
[m,n,c]=size(img);
if(c==3)%RGB?pic
fid_r=fopen('r.mif','w');
fid_g=fopen('g.mif','w');
fid_b=fopen('b.mif','w');
k=0;
fprintf(fid_r,'depth =10000 ;\nwidth = 8;\naddress_radix = UNS;\ndata_radix = DEC;\ncontent begin \n');
fprintf(fid_g,'depth =10000 ;\nwidth = 8;\naddress_radix = UNS;\ndata_radix = DEC;\ncontent begin \n');
fprintf(fid_b,'depth =10000 ;\nwidth = 8;\naddress_radix = UNS;\ndata_radix = DEC;\ncontent begin \n');
for i=1:m
    for j=1:n
        fprintf(fid_r,'%d  :  %d\t;',k,img(i,j,1));
        fprintf(fid_g,'%d  :  %d\t;',k,img(i,j,2));
        fprintf(fid_b,'%d  :  %d\t;',k,img(i,j,3));
        k=k+1;
        fprintf(fid_r,'\n');
        fprintf(fid_g,'\n');
        fprintf(fid_b,'\n');
    end

end
fprintf(fid_r,'END;');
fclose(fid_r);
fprintf(fid_g,'END;');
fclose(fid_g);
fprintf(fid_b,'END;');
fclose(fid_b);
end