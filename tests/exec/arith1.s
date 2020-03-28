	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $4, %rcx
	movq $100, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq $1, %rcx
	movq $102, %rdi
	subq %rcx, %rdi
	call putchar
	movq %rax, %rdi
	movq $4, %rdi
	movq $2, %rcx
	imulq %rdi, %rcx
	movq $100, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rdi
	movq $2, %rdi
	movq $216, %rax
	cqto
	idivq %rdi
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $37, %rcx
	movq $3, %rdi
	imulq %rcx, %rdi
	call putchar
	movq $32, %rax
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $2, %rcx
	movq $1, %rdi
	subq %rcx, %rdi
	movq $0, %rcx
	subq %rdi, %rcx
	movq $118, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rdi
	movq $11, %rdi
	movq $122, %rax
	cqto
	idivq %rdi
	movq $100, %rdi
	addq %rax, %rdi
	call putchar
	movq %rax, %rdi
	movq $2, %rdi
	movq $1, %rcx
	cmpq %rdi, %rcx
	setl %cl
	movzbq %cl, %rcx
	movq $113, %rdi
	addq %rcx, %rdi
	call putchar
	movq $1, %rax
	movq $2, %rdi
	cmpq %rax, %rdi
	setl %dil
	movzbq %dil, %rdi
	movq $108, %rcx
	addq %rdi, %rcx
	movq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq $1, %rcx
	movq $1, %rdi
	addq %rcx, %rdi
	movq $2, %rcx
	cmpq %rdi, %rcx
	sete %cl
	movzbq %cl, %rcx
	movq $99, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rdi
	movq $2, %rdi
	movq $1, %rcx
	cmpq %rdi, %rcx
	sete %cl
	movzbq %cl, %rcx
	movq $10, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
