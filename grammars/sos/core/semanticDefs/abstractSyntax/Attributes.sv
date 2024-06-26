grammar sos:core:semanticDefs:abstractSyntax;

imports sos:core:common:abstractSyntax;


--Environments to pass things down
inherited attribute judgmentEnv::Env<JudgmentEnvItem>;
inherited attribute projectionEnv::Env<ProjectionEnvItem>;
inherited attribute ruleEnv::Env<RuleEnvItem>;

--Pass things up to build the environments
synthesized attribute tyDecls::[TypeEnvItem];
synthesized attribute constructorDecls::[ConstructorEnvItem];
synthesized attribute judgmentDecls::[JudgmentEnvItem];
synthesized attribute projectionDecls::[ProjectionEnvItem];
synthesized attribute ruleDecls::[RuleEnvItem];
synthesized attribute buildsOnDecls::[QName];


--constructor whose argument types we are unifying
inherited attribute lastConstructor::QName;
inherited attribute expectedTypes::Maybe<TypeList>;


--We need to pass around the types of variable names as we generate
--them so all occurrences of the same var have the same type
inherited attribute downVarTypes::[(String, Type)];
synthesized attribute upVarTypes::[(String, Type)];


--Constructors for which projection rules are defined
--e.g. for projection rule `|{T}- c(A, B, C) ~~> X`, we get c
synthesized attribute projRuleConstructors::[QName];
inherited attribute projRuleConstructors_down::[QName];


synthesized attribute isExtensible::Boolean;

synthesized attribute pcIndex::Integer; --zero-based

