	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %r12, -8(%rbp)
	movq %rbx, -16(%rbp)
	movq $65, %rbx
	movq %rbx, %rdi
	movq %rbx, %rdi
	call putchar
	movq $0, %rax
	cmpq $0, %rax
	jz L21
	movq $66, %rax
	movq %rax, %rdi
	call putchar
L6:
	movq %rbx, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq -16(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L21:
	movq $67, %rcx
	movq %rcx, %r12
	movq $68, %r12
	movq %r12, %rdi
	movq %rcx, %rdi
	call putchar
	movq %rax, %rdi
	movq %r12, %rdi
	call putchar
	jmp L6
	.data
