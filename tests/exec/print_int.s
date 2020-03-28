	.text
	.globl main
print_int:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %r12, -8(%rbp)
	movq %rbx, -16(%rbp)
	movq %rdi, %r12
	movq $10, %rdi
	movq %r12, %rbx
	movq %rbx, %rax
	cqto
	idivq %rdi
	movq %rax, %rbx
	movq %rbx, %rdi
	movq $9, %rdi
	movq %r12, %rcx
	cmpq %rdi, %rcx
	setg %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L10
	movq %rbx, %rdi
	call print_int
L10:
	movq %rbx, %rax
	movq $10, %rdi
	imulq %rax, %rdi
	movq %r12, %rcx
	subq %rdi, %rcx
	movq $48, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq -16(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L10
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $42, %rdi
	call print_int
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
