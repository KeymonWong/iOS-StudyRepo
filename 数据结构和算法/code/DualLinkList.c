#include <stdio.h>
#include <stdlib.h>

#define OK 1
#define  ERROR 0

typedef char ElemType;
typedef int Status;

// 双向循环链表结点
typedef struct DualNode 
{
    ElemType data;
    struct DualNode *prev; // 前驱结点
    struct DualNode *next; // 后继结点
} DualNode, *DualLinkList;

Status initList(DualLinkList *L)
{
    DualNode *p, *q;
    int i;

    *L = (DualLinkList)malloc(sizeof(DualNode));
    if (!(*L)) 
    {
        return ERROR;
    }

    (*L)->next = (*L)->prev = NULL;
    p = (*L);

    for (i = 0; i < 26; ++i) 
    {
        q = (DualNode *)malloc(sizeof(DualNode));
        if (!q) 
        {
            return ERROR;
        }

        // 结点连接在一块
        q->data = 'A' + i;
        q->prev = p;
        q->next = p->next;
        p->next = q;

        // 结点移位
        p = q;
    }

    // 循环连接起来，要把第一个结点和最后一个结点连接起来
    p->next = (*L)->next;
    (*L)->next->prev = p;

    return OK;
}

void caesar(DualLinkList *L, int i)
{
    if (i > 0)
    {
        do
        {
            (*L) = (*L)->next;
        } while (--i);
    }
        
    if (i < 0)
    {
        do 
        {
            (*L) = (*L)->next;
        } while (++i);
    }
}

int main()
{
    DualLinkList L;
    int i, n;

    initList(&L);

    printf("请输入一个整数：");
    scanf("%d", &n);
    printf("\n");
    caesar(&L, n);

    for (i = 0; i < 26; i++) 
    {
        L = L->next;
        printf("%c", L->data);
    }

    return 0;
}
 

