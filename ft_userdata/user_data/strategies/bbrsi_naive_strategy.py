# bbrsi_strategy.py
from freqtrade.strategy.interface import IStrategy
from pandas import DataFrame
from freqtrade.strategy import stoploss_from_open
import talib.abstract as ta

class BBRsiStrategy(IStrategy):
    """
    Bollinger Bands (BB) and Relative Strength Index (RSI) strategy.
    """

    # Strategy parameters
    buy_bb_lowerband = 0.0
    sell_bb_upperband = 0.0
    buy_rsi_threshold = 25
    sell_rsi_threshold = 70
    # Minimal ROI designed for the strategy.
    minimal_roi = {
        "60": 0.01,
        "30": 0.02,
        "0": 0.04
    }

    # Stoploss configuration
    stoploss = -0.01
    stoploss_atr = 3

    # Timeframe for Bollinger Bands
    timeframe = '5m'

    def populate_indicators(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        """
        Add Bollinger Bands (BB) and Relative Strength Index (RSI) to the dataframe.
        """
        # Calculate Bollinger Bands
        bollinger = ta.BBANDS(dataframe, timeperiod=20)

        # Add Bollinger Bands to the dataframe
        dataframe['bb_lowerband'] = bollinger['lowerband']
        dataframe['bb_upperband'] = bollinger['upperband']

        # Calculate Relative Strength Index (RSI)
        dataframe['rsi'] = ta.RSI(dataframe)

        return dataframe

    def populate_buy_trend(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        """
        Generate buy signals based on strategy conditions.
        """
        # Buy conditions: Close below lower Bollinger Band and RSI below threshold
        buy_conditions = (
            (dataframe['close'] < dataframe['bb_lowerband'] * (1 - self.buy_bb_lowerband)) &
            (dataframe['rsi'] < self.buy_rsi_threshold)
        )
        dataframe.loc[buy_conditions, 'buy'] = 1

        return dataframe

    def populate_sell_trend(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        """
        Generate sell signals based on strategy conditions.
        """
        # Sell conditions: Close above upper Bollinger Band and RSI above threshold
        sell_conditions = (
            (dataframe['close'] > dataframe['bb_upperband'] * (1 + self.sell_bb_upperband)) &
            (dataframe['rsi'] > self.sell_rsi_threshold)
        )
        dataframe.loc[sell_conditions, 'sell'] = 1

        return dataframe

    def populate_stop_loss(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        """
        Populate stop loss values.
        """
        return stoploss_from_open(dataframe, stoploss=self.stoploss, atr=self.stoploss_atr)
    

# To use this strategy, run Freqtrade with the following command:
# freqtrade trade --strategy BBRsiStrategy --config config.json --exchange binance -v
