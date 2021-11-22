# Modelo de regresión lineal múltiple

# 1 - Visualización del dataframe RIKZ:
head(RIKZ)

# 2 - Se plotea la riqueza en función de diferentes variables:
attach(RIKZ)
plot(angle, richness)
plot(NAP, richness)
plot(grainsize, richness)
plot(humus, richness)

# En base a los ploteos anteriores, puede predecirse que no hay un buen ajuste
# lineal entre riqueza y algunas variables (ángulo y humus).


# 3 - Se elabora un modelo lineal múltiple teniendo en cuenta todas las variables.
#     De acuerdo a la información arrojada por el summary, se removerán 
#     progresivamente las variables explicativas que empeoren el ajuste.
modelo1 = lm(richness ~ angle + NAP + grainsize + humus, data = RIKZ)
summary(modelo1)

# Nuevo modelo, se remueve la variable ángulo:
modelo2 = lm(richness ~ NAP + grainsize + humus, data = RIKZ)
summary(modelo2)

# Nuevo modelo a partir del anterior, se remueve la variable humus:
modelo3 = lm(richness ~ NAP + grainsize, data = RIKZ)
summary(modelo3)

# 4 - Se elige el modelo con el mejor ajuste. Para esto pueden usarse el
#     Akaike Information Criterion (AIC) y el Bayesian Information Criterion (BIC)
#     Estos criterios son estimadores del error de predicción. El modelo con el 
#     mejor ajuste es aquel que tiene el menor valor de AIC/BIC

# Akaike y BIC para cada modelo
AIC(modelo1, modelo2, modelo3)  # El modelo 3 posee el menor valor de AIC
BIC(modelo1, modelo2, modelo3)  # El modelo 3 posee el menor valor de BIC

# Test ANOVA
anova(modelo1, modelo2, modelo3)

# 5 - El proceso anterior puede automatizarse mediante la función step()
#     La función toma el modelo 1 y calcula la variación del AIC para la remoción 
#     de cada variable. La función procede a remover la variable que empeora el 
#     ajuste y reformula el modelo. El proceso se repite hasta que la remoción
#     de cualquier variable genera un valor de AIC más alto que el propio del 
#     último modelo obtenido.
modelo.step = step(modelo1)
summary(modelo.step)
