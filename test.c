// un exemple de fichier mini-C
// à modifier au fur et à mesure des tests
//
// la commande 'make' recompile mini-c (si nécessaire)
// et le lance sur ce fichier

/*** listes circulaires doublement chaînées ***/

struct S{int a; int b;};

int main(){
	struct S *s;
	s = sbrk(sizeof(struct S));
	s->a = s-> b = 1;
	return 0;
}
