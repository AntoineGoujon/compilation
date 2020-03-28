	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $0, %rbx
	movq %rbx, %rcx
	movq $1, %rcx
	movq %rcx, %rdi
	movq $1, %rdi
	cmpq %rdi, %rcx
	sete %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L10
	movq $97, %rdi
	call putchar
L10:
	movq $0, %rax
	movq %rbx, %rdi
	cmpq %rax, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L4
	movq $98, %rdi
	call putchar
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L4
	jmp L10
	.data
