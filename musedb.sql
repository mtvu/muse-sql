select *
from wh.yh_fundamentals;

select max(e."Date")
from wh.yh_daily_equity e
where ticker in ('NAB.AX')

select count(distinct ticker)
from wh.yh_daily_equity

select *
from wh.bc_portfolio p
where p."totChgPct" > 10
  and p.source like '%TRACKING%'
  and p."Time" in (select max(bc_portfolio."Time") from wh.bc_portfolio);


select max(bc_portfolio."Time")
from wh.bc_portfolio;

--Spread searching

select *
from wh.bc_portfolio p,
     wh.bc_opt_bearcall o
where p."Symbol" = o."Symbol"
  and p.source IN ('portfolio-2-PR-SAT-HEDGE-NARWHAL')
  and o.source IN ('screener-SCR-US-OPT-BEARCALLS')
  and o.extracted_on in (select max(extracted_on) from wh.bc_opt_bearcall)
  and p."Time" in (select max(bc_portfolio."Time") from wh.bc_portfolio)
order by maxprofitpc desc;

select *
from wh.bc_opt_bearcall o
where w."Symbol" = o."Symbol"
  and w.source IN ('watchlist-2-WC-INNOIBD-FFTY')
  and o.source IN ('screener-SCR-US-OPT-BEARCALLS')
  and o.extracted_on in (select max(extracted_on) from wh.bc_opt_bearcall)
  and w.extracted_on in (select max(bc_watchlist.extracted_on) from wh.bc_watchlist)
order by maxprofitpc desc;

select *
from wh.bc_daily_usequity e
where e."Symbol" IN ('AAPL')
  and e.extracted_on in (select max(bc_daily_usequity.extracted_on) from wh.bc_daily_usequity)
UNION
select *
from wh.bc_daily_axequity e
where e."Symbol" IN ('NAB.AX')
  and e.extracted_on in (select max(bc_daily_axequity.extracted_on) from wh.bc_daily_axequity)

select *
from wh.bc_screener s
where s.source in ('screener-SCR-US-ETF-TOPDIV')
  and s.extracted_on in (select max(bc_screener.extracted_on) from wh.bc_screener)

select max(bc_daily_axequity.extracted_on)
from wh.bc_daily_axequity


select *
from wh.bc_opt_bearcall o
where o.extracted_on in (select max(extracted_on) from wh.bc_opt_bearcall)
  and o."Symbol" in ('AAPL')
order by maxprofitpc desc;


select *
from wh.bc_watchlist w
where w.source IN ('watchlist-2-WC-INNOIBD-FFTY')
  and w.extracted_on in (select max(bc_watchlist.extracted_on) from wh.bc_watchlist);

select *
from wh.bc_signal s
where s.detected_on > '2020-12-10'
  and signal_type in ('BEAR')
order by symbol desc;

select p.close, p.open, p.high, p.low, p.volume, p.date
from wh.bc_ta p
where p."Symbol" IN ('MQG.AX')
select *
from wh.bc_portfolio s
where s.source in ('portfolio-0-TRACKING-IB-OPTION')
  and s."Time" in (select max(bc_portfolio."Time") from wh.bc_portfolio)

select max(bc_portfolio."Time")
from wh.bc_portfolio

select *
from wh.bc_signal
where symbol in ('SCG.AX')
  and signal_type in ('TA-BULL-REVERSAL')
  and detected_on in ('2020-12-17 00:00:00');

select o."Symbol",
       o."Price",
       o."Type",
       o."Strike",
       o."DTE",
       o."Exp Date",
       o."Midpoint",
       ABS(o."Price" - o."Strike") / o."Price" as moneyness,
       o."Midpoint" / (o."Price" * o."DTE")    as premium_ratio
from wh.bc_daily_usoption o
where ABS(o."Price" - o."Strike") / o."Price" < 0.01
  and o.extracted_on in (select max(extracted_on) from wh.bc_daily_usoption)
order by "Symbol", "Midpoint", "DTE" desc

select o."Symbol",
       o."Price",
       o."Type",
       o."Strike",
       o."DTE",
       o."Exp Date",
       o."Midpoint",
       ABS(o."Price" - o."Strike") / o."Price" as moneyness,
       o."Midpoint" * o."DTE" / o."Price"      as premium_ratio
from wh.bc_daily_etfoption o
where ABS(o."Price" - o."Strike") / o."Price" < 0.01
  and o.extracted_on in (select max(extracted_on) from wh.bc_daily_etfoption)
order by "Symbol", "Midpoint", "DTE" desc

select o."Symbol",
       o."Price",
       o.maxprofit,
       o.maxprofitpc,
       o.maxloss,
       o."BE",
       o."Probability",
       o.expdate,
       o.leg1strike,
       o.leg2strike,
       o.spread,
       o.dte,
       o.extracted_on
from wh.bc_opt_bullcall o
where o.extracted_on in (select max(extracted_on) from wh.bc_opt_bullcall)
order by dte, maxprofitpc desc, o."Symbol" desc;


select o."Symbol",
       o."Price",
       o."Type",
       o."Strike",
       o."DTE",
       o."Exp Date",
       o."Midpoint",
       ABS(o."Price" - o."Strike") / o."Price" as moneyness,
       o."Midpoint" * o."DTE" / o."Price"      as premium_ratio
from wh.bc_ath_usoption o
where ABS(o."Price" - o."Strike") / o."Price" < 0.01
  and o.extracted_on in (select max(extracted_on) from wh.bc_ath_usoption)
order by "Symbol", "Midpoint", "DTE", premium_ratio desc



select *
from wh.bc_ath_usoption o
where "Midpoint" > 5.00
  and o.extracted_on in (select max(extracted_on) from wh.bc_ath_usoption)
order by "Symbol", "Midpoint", "DTE" desc

select *
from wh.bc_daily_ivrank i
where i.extracted_on in (select max(extracted_on) from wh.bc_daily_ivrank)

select distinct source
from wh.bc_portfolio
select *
from bc_process_log
where filename like '%portfolio%'

select *
from wh.bc_ta
where wh.bc_ta."Symbol" in ('MQG.AX')
  and run_on in ('2020-12-22 00:00:00.000000');


select max(yh_daily_equity."Date")
from wh.yh_daily_equity
where ticker in ('NAB.AX')
group by yh_daily_equity."Date"
order by yh_daily_equity."Date"
limit 5;

select count(distinct "Symbol")
from wh.bc_ta

select *
from wh.bc_ta
where wh.bc_ta."Symbol" in ('SPY') --and run_on in ('2021-01-03');

select distinct s.source
from wh.bc_screener s


select o."Symbol",
       o."Price",
       o."Type",
       o."Strike",
       o."DTE",
       o."Exp Date",
       o."Midpoint",
       ABS(o."Price" - o."Strike") / o."Price" as moneyness,
       o."Midpoint" * o."DTE" / o."Price"      as premium_ratio,
       o.extracted_on
from wh.bc_daily_usoption o
where o.extracted_on in (select max(extracted_on) from wh.bc_daily_usoption)
order by "Symbol", "Midpoint", "DTE", premium_ratio desc

select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('NAB.AX')
order by symbol, detected_on desc

select distinct source
from wh.bc_watchlist
select max(run_on)
from wh.bc_ta

select *
from wh.bc_ta
where wh.bc_ta."Symbol" in ('SPY')
  and run_on in ('2020-12-23 00:00:00');

select count(distinct "Symbol")
from wh.bc_ta delete from wh.bc_daily_usequity
where "Symbol" like '%.AX'

select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('FNV')
  and signal_type like 'TA-EMA-%'
order by symbol, detected_on desc

select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY', 'IWM')
  and run_on in ('2020-12-23 00:00:00.000000')
  --and detected_on in (select max(detected_on) from wh.bc_signal)
order by symbol, detected_on desc
select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY')
  and signal_type like 'HA-%'
order by symbol, detected_on desc
    get_current_hasignal
    (['SPY'],1)
select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY')
  and signal_type like 'HA-%'
order by symbol, detected_on desc
select count(*)
from wh.yh_fundamentals

select count(*)
from wh.mc_link

select *
from wh.mc_link
where url in
      ('https://www.economist.com/erasmus/2017/09/10/as-storms-rage-and-waters-rise-religions-speak-with-many-voices')

select p.close, p.open, p.high, p.low, p.volume, p.date, run_on
from wh.bc_ta p
where p."Symbol" IN ('SPY')
  and run_on in (select max(run_on) from wh.bc_ta)

delete
from wh.bc_signal
where run_on in ('2021-01-02')
delete
from wh.bc_ta
where run_on in ('2021-01-02')

delete
from wh.bc_signal
where signal_type like 'HA-BULL'

select *
from wh.bc_signal
where detected_on in (select max(detected_on) from wh.bc_signal)
  and signal_type like 'HA-%'
order by symbol, detected_on desc

select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY', 'IWM')
  and signal_type like 'HA-%'
order by symbol, detected_on desc

select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY')
  and signal_type like 'HA-%'
order by symbol, detected_on desc

select *
from wh.bc_signal m,
     wh.bc_signal s,
     wh.bc_daily_usoption o
where (m.signal_type like 'TA-EMA%' and s.signal_type like 'HA-%')
  and m.symbol = s.symbol
  and o."Symbol" = m.symbol
  and m.detected_on = s.detected_on
  and o.extracted_on in (select max(extracted_on) from wh.bc_daily_usoption)
order by s.detected_on


select *
from wh.bc_signal m,
     wh.bc_signal s
where (m.signal_type like 'TA-EMA%' and s.signal_type like 'HA-%')
  and m.symbol = s.symbol
  and m.detected_on = s.detected_on
order by s.detected_on

select m.symbol      as symbol,
       m.detected_on as detected_on,
       s.signal_type as signal2,
       m.signal_type as signal1,
       "Price",
       "Strike",
       "Type",
       "DTE",
       "Exp Date",
       "Midpoint",
       "Last",
       m.description as sig1desc,
       s.description as sig2desc,
       m.run_on      as run_on,
       extracted_on
from wh.bc_signal m,
     wh.bc_signal s,
     wh.bc_daily_etfoption o
where (m.signal_type like 'TA-EMA%' and s.signal_type like 'HA-%')
  and m.symbol = s.symbol
  and o."Symbol" = m.symbol
  and m.detected_on = s.detected_on
  and o.extracted_on in (select max(extracted_on) from wh.bc_daily_etfoption)
order by s.detected_on, "Type", "Strike", "DTE"

select "Symbol", "Type", "Midpoint"
from wh.bc_daily_usoption o
where ABS(o."Price" - o."Strike") / o."Price" < 0.01
  and "Symbol" in ('NVDA')
  and "Type" in ('Put')
order by "Symbol", "Type", "Strike", "Exp Date"

select m.symbol      as symbol,
       m.detected_on as detected_on,
       s.signal_type as signal2,
       m.signal_type as signal1,
       m.description as sig1desc,
       s.description as sig2desc,
       m.run_on      as run_on,
       extracted_on
from wh.bc_signal m,
     wh.bc_signal s,
     wh.bc_daily_etfoption o
where (m.signal_type like 'TA-EMA%' and s.signal_type like 'HA-%')
  and m.symbol = s.symbol
  and m.detected_on = s.detected_on
order by s.detected_on


select m.symbol      as symbol,
       m.detected_on as detected_on,
       s.signal_type as signal2,
       m.signal_type as signal1,
       m.description as sig1desc,
       s.description as sig2desc,
       m.run_on      as run_on,
from wh.bc_signal m,
     wh.bc_signal s
where (m.signal_type like 'TA-EMA-%' and s.signal_type like 'HA-%')
  and m.symbol = s.symbol
  and m.detected_on = s.detected_on
order by s.detected_on

select count(*)
from bc_ta
where symbol.
          select count (*)
from wh.yh_daily_equity;
select count(distinct "Symbol")
from wh.yh_daily_equity;
select count(distinct "Symbol")
from wh.yh_monthly_equity_async;

delete
from wh.bc_ta
where "Symbol" in
      ('RSX', 'EWG', 'EWT', 'DIA', 'EFA', 'QQQ', 'EPP', 'EWU', 'FXI', 'EWY', 'EWJ', 'SPY', 'INDA', 'VGK', 'IWM', 'EWZ',
       'BKF', 'EEM', 'ONEQ', 'EWA')

select "Symbol", count(*)
from wh.bc_ta delete from wh.yh_monthly_equity
where extracted_on in ('2021-01-05')


INSERT INTO wh.yh_monthly_equity_async("Open", "High", "Low", "Close", "Volume", "Date", "extracted_on", "Symbol")
VALUES (3.75, 4.5625, 3.75, 4.25, 1321800.0, '1998-03-01T00:00:00'::timestamp, '2021-01-06T00:00:00'::timestamp,
        'SRDX'),
       (4.375, 4.875, 4.125, 4.8125, 912400.0, '1998-04-01T00:00:00'::timestamp, '2021-01-06T00:00:00'::timestamp,
        'SRDX')
    get_current_hasignal
    (['SPY'],1)
select *
from wh.bc_signal
where wh.bc_signal."symbol" in ('SPY')
  and signal_type like 'HA-%'
order by symbol, detected_on desc
--Enforce unique rule on bc_ta
create unique index bc_ta_date_uindex
    on wh.bc_ta (date, "Symbol");

create unique index bc_trades_uindex
    on wh.bc_trades (symbol, detected_on, signal2, signal1);
select count(*)
from wh.bc_trades
-- Find duplicate rows in bc_ta
         delete from wh.bc_ta
where "Symbol" in (
    select "Symbol"
    from wh.bc_ta
    Group by "Symbol"
    HAVING COUNT (*)
    > 415)

delete
from wh.bc_signal
where symbol in (select distinct symbol from wh.bc_signal)

select *
from wh.bc_trades
where symbol in ('SPY')
  and detected_on in (select detected_on from wh.bc_trades order by detected_on desc limit 1)


select symbol, COUNT(*)
from wh.bc_signal
Group by symbol

select distinct source
from wh.bc_screener
select *
from wh.bc_screener
where "Symbol" in ('NIO')

select "Symbol", max(run_on) as max_run_on
from wh.bc_ta
group by "Symbol"

create unique index bc_ipo_unique_symbol
    on wh.bc_ipo (symbol);


create unique index bc_signal_unique_signal
    on wh.bc_signal (symbol, signal_type, detected_on);

select nextval('wh.bc_signal_id_seq')
from wh.bc_signal

SELECT setval('wh.bc_signal_id_seq', max(id))
FROM wh.bc_signal

select etf, max(extracted_date)
from wh.bc_etf_holdings
group by etf

select count(*)
from wh.bc_daily_usoption
where extracted_on in (select max(extracted_on) from wh.bc_daily_usoption)
select *
from wh.bc_daily_axequity
where extracted_on in (select max(extracted_on) from wh.bc_daily_axequity)

select distinct "Symbol", count(*)
from wh.yh_daily_equity
where "Symbol" not in (select symbol from wh.yh_profile_stats where run_on not in ('2021-01-11'))
group by "Symbol"
having count(*) > 200

select symbol
from wh.yh_profile_stats
where run_on not in ('2021-01-11')
  and symbol in (select distinct "Symbol" from wh.yh_daily_equity)

delete
from wh.yh_monthly_returns
where run_on in ('2021-01-11')
delete
from wh.yh_profile_stats
where run_on in ('2021-01-11')
delete
from wh.yh_drawdown_details
where run_on in ('2021-01-11')


select "MAR", symbol
from wh.yh_monthly_returns
where year in ('2020')


select *
from wh.bc_daily_usequity
where extracted_on in (select extracted_on from wh.bc_daily_usequity order by extracted_on desc limit 1)

select count(distinct "Symbol")
from wh.bc_daily_usequity
select count(distinct "Symbol")
from wh.bc_daily_usequity
where extracted_on in (select extracted_on from wh.bc_daily_usequity order by extracted_on desc LIMIT 1)

ALTER TABLE wh.bc_opt_trades
    ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE wh.bc_trades
    ADD COLUMN id SERIAL PRIMARY KEY;
select symbol, extracted_on
from wh.bc_opt_trades
where extracted_on is not null
group by symbol, extracted_on
order by extracted_on
delete
from wh.bc_opt_trades
where extracted_on in ('2021-01-11')
delete
from wh.bc_opt_trades
where extracted_on is null

delete
from wh.bc_daily_usequity
where "Symbol" in (select "Symbol" from wh.bc_daily_etf)

select count(*)
from wh.bc_daily_usequity
where extracted_on in ('2021-01-12 00:00:00')

select *
from wh.bc_opt_trades
limit 5
select extracted_on
from wh.bc_opt_trades
where extracted_on is not null
order by extracted_on desc
limit 1

select distinct "Symbol", "Last", "5Dchgpct", "ytdchgpct", "3Ychgpct"
from wh.bc_screener
where "5Dchgpct" > 0
  and "ytdchgpct" > 20
  and "3Ychgpct" > 0
  and "Last" > "200D MA"
  and source in ('screener-SCR-US-EQT-1PCSIGNAL', 'screener-SCR-US-EQT-ATH', 'screener-SCR-US-EQT-TOPUND10',
                 'screener-SCR-US-EQT-5DAYG', 'screener-SCR-US-EQT-TOP2OWN', 'screener-SCR-US-EQT-SECTOR100')
  and extracted_on in (select max(wh.bc_screener.extracted_on) from wh.bc_daily_usequity)

select distinct "Symbol", "Last", "5Dchgpct", ytdchgpct, "3Ychgpct"
from wh.bc_daily_usequity
where "5Dchgpct" > 0
  and ytdchgpct > 15
  and "3Ychgpct" >= 0
  and extracted_on in (select max(wh.bc_daily_usequity.extracted_on) from wh.bc_daily_usequity)



select etf, max(extracted_date)
from wh.bc_etf_holdings
where etf in ('IWM', 'SPY')
group by etf

select *
from wh.bc_etf_holdings
where etf in ('IWM', 'SPY')
group by etf
order by etf

select distinct cik
from wh.bc_sec_filing_focus
where form in ('S-1')
delete
from wh.bc_opt_trades
where id < 109594

select *
from wh.bc_trades
where symbol in ('SPY', 'IWM')


select distinct s."Symbol"
from wh.bc_watchlist s
where s.source in ('watchlist-2-WC-REIT-VNQ-VAP-XRE')
  and s.extracted_on in (select max(bc_watchlist.extracted_on) from wh.bc_watchlist)


select *
from wh.bc_trades
where symbol in
      ('DLR', 'CTRE', 'JOE', 'KRG', 'MMI', 'NSA', 'NXRT', 'STAR', 'UHT', 'AMT', 'CBRE', 'CCI', 'EQIX', 'EQR', 'ESS',
       'EXR', 'ADC', 'DEA', 'FCPT', 'GTY', 'IRT', 'LTC', 'LXP', 'ARE', 'AVB', 'DRE', 'KIM', 'O', 'MAA', 'PLD', 'SBAC',
       'PSA', 'UDR', 'WELL', 'CONE', 'PCH', 'GLPI', 'LAMR', 'RDFN', 'CHP-UN.TO', 'CAR-UN.TO', 'CRR-UN.TO', 'KMP-UN.TO',
       'GRT-UN.TO', 'IIP-UN.TO', 'ACC', 'AMH', 'BRX', 'COR', 'CPT')

select *
from wh.bc_daily_usoption
where Type in ('Call')

select distinct extracted_on
from wh.bc_opt_trades
order by extracted_on desc

select *
from wh.bc_opt_trades
where extracted_on in (select extracted_on from wh.bc_opt_trades order by extracted_on desc LIMIT 1)

-- signal
select * from wh.bc_signal
where signal_type like ('HA-TREND%')

