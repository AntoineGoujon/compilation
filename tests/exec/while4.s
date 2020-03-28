	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $10, %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
L16:
	movq %rbx, %rdi
	cmpq $0, %rdi
	jz L4
	movq $1, %rdi
	movq %rbx, %rcx
	subq %rdi, %rcx
	movq %rcx, %rbx
	movq %rbx, %rcx
	movq %rbx, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	jmp L16
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
