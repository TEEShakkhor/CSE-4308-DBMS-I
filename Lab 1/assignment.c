#include<stdio.h>
#include<string.h>

struct Info
{
    char *name;
    char *address;
    char *salary;
    char *bloodGrp;
};

int main()
{
    FILE *fp1, *fp2, *fp3;
    char s1[10000];
    char s2[10000];
    char c, d;
    char *infos1[3], *infos2[3];

    fp1 = fopen("D://DBMS Lab//file-1.txt", "r");
    fp2 = fopen("D://DBMS Lab//file-2.txt", "r");
    fp3 = fopen("D://DBMS Lab//output-2.txt", "w");

    if(fp1 == NULL || fp2 == NULL || fp3 == NULL)
    {
        printf("File not found!");
    }
    else
    {
        struct Info p;
        while(fgets(s1, 10000, fp1) && fgets(s2, 10000, fp2))
        {
            struct Info p;

            char *token1 = strtok(s1, ",");

            int i = 0;
            while(token1 != NULL)
            {
                infos1[i++] = token1;
                token1 = strtok(NULL, ",");
            }

            int j=0;
            char *token2 = strtok(s2, ",");
            while(token2 != NULL)
            {
                infos2[j++] = token2;
                token2 = strtok(NULL, ",");
            }
            p.name = infos1[0];
            p.address = infos1[1];
            p.salary = infos1[2];
            p.bloodGrp = infos2[2];

            int k = 0;
            while(p.salary[k] != '\0')
            {
                if(p.salary[k] == '\n')
                {
                    p.salary[k] = '\0';
                }
                ++k;
            }

            if(p.bloodGrp[0] == 'B' && p.bloodGrp[1] == '+')
                fprintf(fp3, "%s,%s,%s,%s", p.name, p.address, p.salary, p.bloodGrp);
        }

        fclose(fp1);
        fclose(fp2);
        fclose(fp3);

        printf("Operation finished!!!");
    }
    return 0;
}
