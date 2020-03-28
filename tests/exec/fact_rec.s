	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq $1, -24(%rbp)
	movq $0, %rdi
	call fact_rec
	cmpq -24(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L18
	movq $49, %rdi
	call putchar
	movq %rax, -8(%rbp)
L18:
	movq $1, -8(%rbp)
	movq $1, %rdi
	call fact_rec
	cmpq -8(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L11
	movq $50, %rdi
	call putchar
	movq %rax, -16(%rbp)
L11:
	movq $120, -16(%rbp)
	movq $5, %rdi
	call fact_rec
	cmpq -16(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L4
	movq $51, %rdi
	call putchar
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L4
	jmp L11
	jmp L18
fact_rec:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq %rdi, %rbx
	movq $1, %rdi
	movq %rbx, %rcx
	cmpq %rdi, %rcx
	jle L33
	movq $1, %rcx
	movq %rbx, %rdi
	subq %rcx, %rdi
	call fact_rec
	imulq %rax, %rbx
L26:
	movq %rbx, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L33:
	movq $1, %rbx
	jmp L26
	.data
