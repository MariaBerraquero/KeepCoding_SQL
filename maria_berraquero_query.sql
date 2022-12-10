-- Consulta para sacar el siguiente listado de coches activos que hay en KeepCoding: Nombre modelo, marca y grupo de coches (los nombre de todos),
-- fecha de compra, matricula, nombre del color del coche, total kilómetros, nombre empresa que esta asegurado el coche y número de póliza.

SELECT a.license_plate, a.dt_purchase, a.kms, b.name_color, c.name_model, d.name_brand, e.name_company, f.id_policy, g.name_ins_company
FROM practica_mbg.cars a, practica_mbg.colors b, practica_mbg.models c, practica_mbg.brands d, practica_mbg.companies e, practica_mbg.policies f, practica_mbg.insurance_companies g
WHERE a.id_color = b.id_color and a.id_model = c.id_model and c.id_brand = d.id_brand and d.id_company = e.id_company and a.id_car = f.id_car and f.id_ins_company = g.id_ins_company;
