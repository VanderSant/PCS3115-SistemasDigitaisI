--
-- PCS3115 - Sistemas Digitais I
-- 1o Semestre de 2020
--------
-- Projeto 4 - LittleSort
--
-- Este arquivo contem:
-- 1- Componentes usados para o testbench (mux_2to1 e ram16x4)
-- 2- Unidade de controle do circuito LittleSort
-- 3- Entidade principal do circuito LittleSort
-- 4- Entidade littlesort_tb (testbench reduzido)
--
-- Usar tambem o arquivo memoria1.dat em anexo no arquivo zip
--
-- Codificaçao: Edson Midorikawa
-- Verificacao: Marco Tulio Carvalho de Andrade
--
-- 2020-07-03
--

-------------------------------------------------------
--! @file mux4_2to1.vhd
--! @brief 2-to-1 1-bit multiplexer
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-30
-------------------------------------------------------

-------------------------------------------------------
--! @file ram16x4.vhd
--! @brief synchronous ram 16x4
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-16
-------------------------------------------------------
-- baseado em ram.vhd (balbertini@usp.br)
-------------------------------------------------------


-------------------------------------------------------
--! @file littlesort_uc.vhd
--! @brief control unit for littlesort
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-30
-------------------------------------------------------

-------------------------------------------------------
--! @file littlesort.vhd
--! @brief littlesort circuit
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-30
-------------------------------------------------------



-------------------------------------------------------
--! @file littlesort_tb.vhd
--! @brief testbench for littlesort circuit
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-19
-------------------------------------------------------


