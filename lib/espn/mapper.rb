module ESPN

  # Public: A module that handles mapping to make the ESPN API a little easier
  # to digest.
  #
  # Examples
  #
  #   class Client
  #     include ESPN::Mapper
  #   end
  module Mapper

    # Public: Map all common leagues to sports.
    LEAGUE_MAP = {
      baseball: %w(mlb college-baseball),
      basketball: %w(nba wnba mens-college-basketball womens-college-basketball),
      football: %w(nfl college-football),
      golf: %w(eur lpga pga sga web),
      hockey: %w(nhl mens-college-hockey womens-college-hockey),
      mma: %w(affliction bamma bfc ifl k1 lfc m1 mfc pancrase pride ringside
              sharkfights shooto shootobrazil shootojapan shoxc sfl strikeforce
              tpf ufc wec),
      racing: %w(irl sprint nationwide truck f1 nhra),
      soccer: %w(arg.1 uefa.champions fifa.world aut.1 bel.1 den.1 fra.1 ger.1
                 ned.1 ita.1 nor.1 por.1 esp.1 swe.1 sui.1 tur.1 usa.1 usa.w.1
                 mex.1 eng.1 eng.2 eng.3 eng.4 eng.5 eng.fa eng.worthington
                 eng.trophy eng.charity uefa.uefa sco.1 sco.2 sco.3 sco.4
                 sco.tennents sco.cis sco.challenge uefa.intertoto fifa.friendly
                 uefa.worldq uefa.euroq fifa.confederations
                 conmebol.libertadores concacaf.gold fifa.wwc fifa.worldq
                 fifa.worldq.afc fifa.worldq.caf fifa.worldq.concacaf
                 fifa.worldq.conmebol fifa.worldq.ofc fifa.worldq.uefa friendly
                 usa.open fifa.friendly.w fifa.olympics fifa.olympicsq fifa.wyc
                 uefa.euro intercontinental caf.nations fifa.w.olympicsq
                 fifa.w.algarve esp.copa_del_rey conmebol.america
                 fifa.w.olympics bra.1 chi.1 fra.2 ger.2 gre.1 ita.2 ned.2
                 rus.1 esp.2 wal.1 irl.1 fra.coupe_de_la_ligue
                 fra.coupe_de_france esp.super_cup nir.1 usa.misl
                 conmebol.sudamericana uefa.super_cup aus.1 col.1 uru.1 per.1
                 par.1 usa.ncaa.1 usa.ncaa.w.1 fifa.cwc ecu.1 ven.1 bol.1
                 arg.urba ger.dfb_pokal ita.coppa_italia ned.cup rsa.1 rsa.2
                 jpn.1 afc.champions afc.cup slv.1 crc.1 afc.cupq hon.1 gua.1
                 aff.championship conmebol.sudamericano_sub20
                 concacaf.champions_cup uefa.euro_u21 fifa.world.u20
                 usa.world_series concacaf.superliga fifa.world.u17 concacaf.u23
                 usa.usl.1 arg.2 col.2 uefa.euro.u19 concacaf.champions bra.2
                 uru.2 arg.4 par.2 ven.2 arg.5 per.2 mex.2 chi.2 arg.3
                 mex.interliga uefa.europa ecu.2 global.world_football_challenge
                 uefa.carling eng.w.1 ger.super_cup ita.super_cup rug.irb.world
                 panam.m panam.w arg.copa),
      tennis: %w(atp wta)
    }

    # Public: Map a league to a sport.
    #
    # league  - The league (String or Symbol) to map to a sport.
    #
    # Examples
    #
    #   map_league_to_sport(:nhl)
    #   # => { league: 'nhl', sport: 'hockey' }
    #   map_league_to_sport('mlb')
    #   # => { league: 'mlb', sport: 'baseball' }
    #   map_league_to_sport('some-random-league')
    #   # => { league: 'some-random-league', sport: '' }
    #
    # Returns a Hash.
    def map_league_to_sport(league)
      result = { league: league.to_s, sport: nil }

      LEAGUE_MAP.each do |sport, leagues|
        if leagues.include? result[:league]
          result[:sport] = sport.to_s
          break
        end
      end

      result
    end

  end
end
