#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char x[100];//="13*2*2";
    int rezultat_final=0;

    printf("> Introduceti o expresie: \n");
    scanf("%s",x);
    for(int i=0;i<strlen(x);i++)
    {
        if(x[i]==' ')
        {   printf("%d\n",i);
            for(int j=i;j<strlen(x);j++)
                x[j]=x[j+1];
            i--;
        }
    }

    while(strcmp(x,"exit")!=0)
    {
        char op[100];
        int num[100],op_c=0,num_c=0;
        int n=0;

        strcat(x,"+");

        int contor=0;
        if(x[0]=='+' || x[0]=='-' || x[0]=='*' || x[0]=='/')
        {
            op[op_c]=x[0];
            op_c++;
            num[num_c]=rezultat_final;
            num_c++;
            contor++;
        }

        for(int i=contor; i<strlen(x); i++)
        {
            if(x[i]=='+' || x[i]=='-' || x[i]=='*' || x[i]=='/')
            {

                    num[num_c]=n;
                    num_c++;

                    op[op_c]=x[i];
                    op_c++;

                    n=0;
            }
            else
            {
                n=n*10+(x[i]-'0');
            }
        }
        puts("OPERATORI:");
        for(int i=0; i<op_c; i++)
            printf("%c ",op[i]);
        puts("\nNUMERE:");

        for(int i=0; i<num_c; i++)
            printf("%d ",num[i]);

        for(int i=0; i<op_c; i++)
        {
            if(op[i]=='*' || op[i]=='/')
            {
                if(op[i]=='*')
                {
                    num[i+1]=num[i+1]*num[i];
                }
                if(op[i]=='/')
                {
                    num[i+1]=num[i]/num[i+1];
                }

                op[i]='?';
                num[i]=-1;
            }

        }

        for(int i=0; i<op_c-1; i++)
        {
            if(op[i]!='?')
            {
                int j;
                for( j=i+1; j<op_c; j++)
                {
                    if(op[j]!='?')
                        break;
                }
                if(op[i]=='+')
                {
                    num[j]=num[j]+num[i];
                }
                if(op[i]=='-')
                {
                    num[j]=num[i]-num[j];
                }
                op[i]='?';
                num[i]=-1;

            }
        }

        rezultat_final=num[num_c-1];

        printf("\n= %d\n",rezultat_final);

        printf("> Introduceti o expresie:\n ");
        scanf("%*c%s",x);

    }
    puts("Multumesc ca ati utilizat calculatorul meu de buzunar! :*");

    return 0;
}

/*for(int i=0; i<op_c; i++)
            printf("%c ",op[i]);
        puts("\n");

        for(int i=0; i<num_c; i++)
            printf("%d ",num[i]);*/

/* switch (x[i])
                    {
                    case '+' :
                        op[op_c]='+';
                        op_c++;
                        break;
                    case '-' :
                        op[op_c]='-';
                        op_c++;
                        break;
                    case '*' :
                        op[op_c]='*';
                        op_c++;
                        break;
                    case '/' :
                        op[op_c]='/';
                        op_c++;
                        break;
                    default:
                        "ai ajuns la final! Bravo!"
                        ;
                    }*/
