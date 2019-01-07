/**
 * 
 */
(function(){
	var a=new function(){
		var h=Math.atan(1)/45;
		this.l=115.8;
		this.m=-474.99;
		this.n=-674.11;
		this.c=1.16/3600*h;
		this.d=-2.31/3600*h;
		this.b=-1.63/3600*h;
		this.a=-6.43*1.0E-6};
		var n=new function(){
			this.f=6377397.155;
			this.k=1/299.152813;
			this.t=5E5;this.u=2E5;
			this.o=1;this.g=38;
			this.h=127+10.405/3600
			},
			o=Math.atan,s=Math.cos,t=Math.sin,w=Math.pow,A=Math.sqrt;
			function B(h,i){
				this.x=h;
				this.y=i
				}B.prototype.toString=function(){return"("+this.x+", "+this.y+")"};function C(h,i,f,b,q,u){this.i=q;this.j=u;this.p=h+q;this.r=i+u;this.q=f+q;this.s=b+u}var D=[new C(112500,-5E4,146E3,3E3,0,5E4),new C(146E3,-5E4,191600,8600,0,5E4),new C(13E4,44E3,145E3,58E3,0,1E4),new C(532500,437500,557500,462500,-70378,-136),new C(625E3,412500,65E4,437500,-144738,-2161),new C(-12500,462500,5E3,512500,23510,-111),new C(191600,-5E4,194200,2700,0,5E4),new C(194200,-5E4,2E5,8600,0,5E4)];
B.prototype.e=function(){for(var h=0.4*this.x,i=0.4*this.y,f=0;f<D.length;++f){var b=D[f];if(b.p<=h&&h<=b.q&&b.r<=i&&i<=b.s){h-=b.i;i-=b.j;break}}var f=n.f,q=n.t,u=n.u,b=n.o,v=n.g,x=n.h,g=0,l=g=0,e=0,k=0,j=0,d=e=0,m=0,r=d=e=0,c=0,y=0,z=0,E=0,F=r=e=c=m=d=k=0,p=z=y=d=g=0,g=p=k=m=e=p=d=0,e=n.k;1<e&&(e=1/e);k=u;j=o(1)/45;g=v*j;l=x*j;e=1/e;d=f*(e-1)/e;m=(f*f-d*d)/(f*f);e=(f*f-d*d)/(d*d);d=(f-d)/(f+d);r=f*(1-d+5*(d*d-w(d,3))/4+81*(w(d,4)-w(d,5))/64);c=3*f*(d-d*d+7*(w(d,3)-w(d,4))/8+55*w(d,5)/64)/2;y=15*
f*(d*d-w(d,3)+3*(w(d,4)-w(d,5))/4)/16;z=35*f*(w(d,3)-w(d,4)+11*w(d,5)/16)/48;E=315*f*(w(d,4)-w(d,5))/512;g=r*g-c*t(2*g)+y*t(4*g)-z*t(6*g)+E*t(8*g);F=(i+g*b-q)/b;p=f*(1-m)/w(A(1-m*w(t(0),2)),3);g=F/p;for(i=1;5>=i;i++)d=r*g-c*t(2*g)+y*t(4*g)-z*t(6*g)+E*t(8*g),p=f*(1-m)/w(A(1-m*w(t(g),2)),3),g+=(F-d)/p;p=f*(1-m)/w(A(1-m*w(t(g),2)),3);r=f/A(1-m*w(t(g),2));d=t(g);m=s(g);c=d/m;e*=m*m;k=h-k;d=c/(2*p*r*b*b);y=c*(5+3*c*c+e-4*e*e-9*c*c*e)/(24*p*w(r,3)*w(b,4));z=c*(61+90*c*c+46*e+45*w(c,4)-252*c*c*e-3*e*e+100*
w(e,3)-66*c*c*e*e-90*w(c,4)*e+88*w(e,4)+225*w(c,4)*e*e+84*c*c*w(e,3)-192*c*c*w(e,4))/(720*p*w(r,5)*w(b,6));p=c*(1385+3633*c*c+4095*w(c,4)+1575*w(c,6))/(40320*p*w(r,7)*w(b,8));g=g-k*k*d+w(k,4)*y-w(k,6)*z+w(k,8)*p;d=1/(r*m*b);p=(1+2*c*c+e)/(6*w(r,3)*m*w(b,3));e=(5+6*e+28*c*c-3*e*e+8*c*c*e+24*w(c,4)-4*w(e,3)+4*c*c*e*e+24*c*c*w(e,3))/(120*w(r,5)*m*w(b,5));m=(61+662*c*c+1320*w(c,4)+720*w(c,6))/(5040*w(r,7)*m*w(b,7));k=k*d-w(k,3)*p+w(k,5)*e-w(k,7)*m;i=[(l+k)/j,g/j];f=i[1];l=i[0];i=[];j=q=j=j=b=h=b=0;j=
1/299.152813;1<j&&(j=1/j);b=o(1)/45;h=f*b;b*=l;j=1/j;j=6377397.155*(j-1)/j;f=(4.067119447260209E13-j*j)/4.067119447260209E13;l=t(h);q=6377397.155/A(1-f*l*l);i[0]=(q+0)*s(h)*s(b);i[1]=(q+0)*s(h)*t(b);i[2]=(j*j/4.067119447260209E13*q+0)*t(h);h=i;b=f=i=0;i=(h[0]-a.l)*(1+a.a);f=(h[1]-a.m)*(1+a.a);b=(h[2]-a.n)*(1+a.a);h=[];h[0]=1/(1+a.a)*(i-a.b*f+a.d*b);h[1]=1/(1+a.a)*(a.b*i+f-a.c*b);h[2]=1/(1+a.a)*(-a.d*i+a.c*f+b);i=h[0];v=h[1];b=h[2];k=l=k=u=g=q=j=l=l=f=x=h=0;l=1/298.257223563;1<l&&(l=1/l);h=o(1)/45;
l=1/l;j=6378137*(l-1)/l;q=(40680631590769-j*j)/40680631590769;l=o(v/i);u=A(i*i+v*v);g=6378137;for(v=0;30>v;++v){k=(j*j/40680631590769*g+k)*(j*j/40680631590769*g+k)-b*b;k=b/A(k);f=o(k);if(1.0E-18>Math.abs(f-x))break;x=A;k=q;g=t(f);g=6378137/x(1-k*g*g);k=u/s(f)-g;x=f}b=[];b[0]=f/h;b[1]=l/h;0>i&&(b[1]=180+b[1]);0>b[1]&&(b[1]=360+b[1]);return new daum.maps.LatLng(b[0],b[1])};B.prototype.toCoords=function(){return this.e().toCoords()};daum.maps.Congnamul=B;var G=B.prototype;G.toLatLng=G.e;G.toCoords=G.toCoords;})();