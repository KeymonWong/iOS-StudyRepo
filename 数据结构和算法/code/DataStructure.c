#include "stdio.h"

/**
 * @brief 线性表的并集
 * 
 * La表示 A 集合，Lb 表示 B 集合
 */
void unionL(List *La, List Lb) {
    int La_len, Lb_len, i;

    ElemType e;
    La_len = ListLength(*La); ///<线性表长度
    Lb_len = ListLength(Lb);
    
    //遍历线性表 Lb
    for(i = 1; i <= Lb_len; i++) {
        //获取线性表 Lb 中第 i 个位置元素，并赋值给 e
        GetElem(Lb, i, &e);
        //判断线性表 La 中是否有 e，没有的话的把该元素插入 La 中，La 的长度相应加1
        if (!LocateElem(*La, e)) {
            ListInsert(La, ++La_len, e);
        }
    }
}

/*************** --- 顺序存储结构的线性表 begin --- *******************/

/*************** --- 分割线 --- *******************/

#define MAXSIZE 60
typedef int ElemType;
typedef struct {
    ElemType data[MAXSIZE];
    int length; //线性表长度，即当前线性表中数据元素的个数
} SqList;

/*************** --- 分割线 --- *******************/

/**
 * @brief 获取线性表中某个位置的元素
 * 
 * Status 是函数的类型，其值是函数结果状态代码，如 OK 等。
 * 初始条件：顺序线性表 L 已经存在，并且 1 <= i <= ListLength(L)
 * 操作结果：用 e 返回 L 中第 i 个数据元素的值
 */
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

//也可以直接用 int，这里方便表示操作结果状态
typedef int Status;

Status GetElem(SqList L, int i, ElemType *e) {
    if (L.length == 0 || i < 1 || i > L.length) {
        return ERROR;
    }

    *e = L.data[i-1];
    return OK;
}

/*************** --- 分割线 --- *******************/

/**
 * @brief 在线性表中某个位置插入新元素，note：线性表的位置是从 1 开始计的，和数组不同哦
 * 
 * 插入思路：
 * - 若插入位置不合理，则抛异常
 * - 若线性表长度大于等于数组长度，则抛异常
 * - 从最后一个元素向前遍历到第 i 个位置，分别向后移动一个位置
 * - 将新元素填入位置 i 处
 * - 线性表长度 +1
 * 
 * Status 是函数的类型，其值是函数结果状态代码，如 OK 等。
 * 初始条件：顺序线性表 L 已经存在，并且 1 <= i <= ListLength(L)
 * 操作结果：在 L 中第 i 个位置之前插入新的数据元素 e，L 长度 +1
 */
Status ListInsert(SqList *L, int i, ElemType e) {
    int k;
    
    //线性表已经满了
    if (L->length == MAXSIZE) {
        return ERROR;
    }
    //i 不在范围内
    if (i < 1 || i > L->length + 1) {
        return ERROR;
    }
    //若插入元素位置不在表尾之后的位置
    if (i <= L->length) {
        //线性表第 i 位置之后的所有元素后移一位，倒序遍历
        for(k = L->length-1; k >= i-1; k--) {
            L->data[k+1] = L->data[k];
        }
    }
        
    //插入新元素，线性表当前长度 +1
    L->data[i-1] = e;
    L->length++;
    
    return OK;
}

/*************** --- 分割线 --- *******************/

/**
 * @brief 删除线性表中某个位置的元素，note：线性表的位置是从 1 开始计的，和数组不同哦
 * 
 * 删除思路：
 * - 若删除位置不合理，则抛异常
 * - 取出删除元素
 * - 从删除元素位置开始遍历到最后一个元素，分别将每一个元素前移一个位置
 * - 线性表长度 -1
 * 
 * Status 是函数的类型，其值是函数结果状态代码，如 OK 等。
 * 初始条件：顺序线性表 L 已经存在，并且 1 <= i <= ListLength(L)
 * 操作结果：删除 L 中第 i 个位置数据元素，L 长度 -1，并用 e 返回其值
 */
Status ListDelete(SqList *L, int i, ElemType *e) {
    int k;
    
    //空表
    if (L->length == 0) {
        return ERROR;
    }
    //i 不在范围内
    if (i < 1 || i > L->length) {
        return ERROR;
    }
    
    //取出该位置元素
    *e = L->data[i-1];

    //如果删除的不是线性表中最后一个元素，则要遍历，如果删的是最后一个元素就不必遍历了
    if (i < L->length) {
        //线性表第 i 位置之后的所有元素前移一位
        for(k = i; k < L->length; k++) {
            L->data[k-1] = L->data[k];
        }
    }
    
    L->length--; 
    
    return OK;
}

/*************** --- 顺序存储结构的线性表 end --- *******************/


/*************** --- 链式存储结构的线性表 begin --- *******************/

typedef struct Node {
    ElemType data; //数据域
    struct Node *next; //指针域
} Node;

typedef struct Node *LinkList;

/**
 * @brief 单链表第 i 个结点之前插入结点
 * 注意：不能先断开再插入，必须先插入再断开
 * 思路：
 * - 声明一结点 p 指向链表头结点，初始化 j 从1开始
 * - 当 j 小于 i 时，就遍历链表，让 p 的指针向后移动，不断指向下一个结点，j 累加
 * - 若到链表末尾 p 为空，则说明第 i 个元素不存在
 * - 否则查找成功，在系统中生成一个空结点 s
 * - 将数据元素 e 赋值给 s->data
 * - 执行插入操作
 * - 返回成功
 * 
 * Status 是函数的类型，其值是函数结果状态代码，如 OK 等。
 */
Status LinkList_insert(LinkList *L, int i, ElemType e) {
    int j = 1;
    LinkList p, s;

    p = *L;
    
    //查找第 i 个结点
    while(p && j<i){
        p = p->next;
        j++;
    }

    if(!p || j>i) {
        return ERROR;
    }

    //生成结点
    s = (LinkList)malloc(sizeof(Node));
    s->data = e;

    //插入，注意：不能先断开再插入，必须先插入再断开。即下面两句代码顺序不能反
    s->next = p->next;
    p->next = s;

    return OK;
}

/**
 * @brief 删除单链表中第 i 位置的结点
 * 
 * 思路：
 * - 声明一结点 p 指向链表第一个点，初始化 j 从1开始
 * - 当 j 小于 i 时，就遍历链表，让 p 的指针向后移动，不断指向下一个结点，j 累加
 * - 若到链表末尾 p 为空，则说明第 i 个元素不存在
 * - 否则查找成功，将待删除结点 p->next 赋值给 q
 * - 执行删除
 * - 将 q 结点的数据赋值给 e 返回
 * - 释放 q 结点
 * 
 * Status 是函数的类型，其值是函数结果状态代码，如 OK 等。
 */
Status LinkList_delete(LinkList *L, int i, ElemType *e) {
    int j=1;
    LinkList p, q;

    p = *L;

    while(p->next && j<i){
        p = p->next;
        ++j;
    }

    if (!(p->next) || j>i) {
        return ERROR;
    }
    
    //下述两句代码等效于：p->next = p->next->next
    q = p->next;
    p->next = q->next;

    *e = q->data;
    free(q);

    return OK;
}

/**
 * @brief 头插法建立 无头结点单链表，生成的链表结点的顺序和输入的顺序正好是相反的
 * 
 * 从一个空表开始，生成新结点，读取数据存放到新结点的数据域中，然后将新结点插入到当前链表的表头，直到结束。
 * 简单来说就是把新加入的元素放在表头后的第一个位置
 * - 先让新结点的 next 指向头节点之后
 * - 然后让表头的 next 指向新结点
 */
void CreateLinkList_ViaHeadInsert(LinkList *L, int n) {
    LinkList p;
    int i;

    //初始化随机数种子
    srand(time(0));
    
    //初始化空表
    *L = (LinkList)malloc(sizeof(Node));
    (*L)->next = NULL;
    
    for(i = 0; i < n; i++) {
        p = (LinkList)malloc(sizeof(Node)); ///<生成新结点
        p->data = rand() % 100 + 1;
        p->next = (*L)->next;
        (*L)->next = p;
    }
}

/**
 * @brief 尾插法建立 无头结点单链表，生成的链表结点的顺序和输入的顺序正好是相同的，很重要
 * 
 * 从一个空表开始，生成新结点，读取数据存放到新结点的数据域中，然后将新结点插入到当前链表的表头，直到结束。
 * 简单来说就是把新加入的元素放在表头后的第一个位置
 * - 先让新结点的 next 指向头节点之后
 * - 然后让表头的 next 指向新结点
 */
void CreateLinkList_ViaTailInsert(LinkList *L, int n) {
    LinkList p, r;
    int i;

    srand(time(0));

    *L = (LinkList)malloc(sizeof(Node));
    r = *L; ///<关键
    
    for(i = 0; i < n; i++) {
        p = (LinkList)malloc(sizeof(Node));
        p->data = rand() % 100 + 1;
        p->next = r->next;
        r->next = p;
        r = p; ///< p 结点赋值给 r 结点，即新插入的这个处于尾部的结点 有两个名字(叫 p 或者叫 r 都可以）
    }
    r->next = NULL;
}

/**
 * @brief 单链表整表删除，先判断是不是空表
 * 
 * - 声明结点 p 和 q；
 * - 将第一个结点赋值给 p，下一个结点赋值给 q；
 * - 循环执行释放 p 和将 q 赋值给 p；
 */
Status ClearLinkList(LinkList *L) {
    LinkList p, q;

    p = (*L)->next;
    
    if(p) {
        //判断结点 p 是否存在
        while(p) {
            q = p->next;
            free(p);
            p = q;
        }

        (*L)->next = NULL;

        return OK;
    } 
    else {
        printf('这是一个空表');
        return ERROR;
    }
}

/*************** --- 链式存储结构的线性表 end --- *******************/


/*************** --- 静态链表 begin --- *****************/

typedef struct {
    ElemType data; ///<数据
    int cur; ///<游标
} Component, StaticLinkList[MAXSIZE];

/**
 * @brief 静态链表初始化，相当于初始化数组
 *
 * 空的静态链表如下:
 * 
 * 游标  1   2   3   4   5  ...     0     
 * 数据  —                  ...     -
 * 下标  0   1   2   3   4  ...  MAXSIZE-1
 *
 */
Status InitStaticLinkList(StaticLinkList space) {
    int i;
    
    for(i = 0; i < MAXSIZE-1; i++) {
        space[i].cur = i + 1;
    }
    //空表
    space[MAXSIZE-1].cur = 0;


    return OK;
}

/**
 * @brief 静态链表插入
 *
 * 空的静态链表如下:
 * 
 * 游标  1   2   3   4   5  ...     0     
 * 数据  —                  ...     -
 * 下标  0   1   2   3   4  ...  MAXSIZE-1
 *
 */

/**
 * @brief 静态链表删除
 *
 * 空的静态链表如下:
 * 
 * 游标  1   2   3   4   5  ...     0     
 * 数据  —                  ...     -
 * 下标  0   1   2   3   4  ...  MAXSIZE-1
 *
 */

/*************** --- 静态链表 end --- *******************/


/*************** --- 静态链表 begin --- *******************/


/*************** --- 静态链表 end --- *******************/

/**
 * @brief 题目：快速找到未知长度单链表的中间节点
 * @answer 快慢指针实现
 */
Status GetMidNode(LinkList L, ElemType *e) {
    LinkList search, mid;
    mid = search = L;
    
    while(search->next != NULL) {
        //search 的移动速度是 mid 的2倍
        if (search->next->next != NULL) {
            search = search->next->next;
            mid = mid->next;
        } else {
            search = search->next;
        }
        
        *e = mid->data;
        return OK;
    }
}