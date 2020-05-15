module ISX.Plugin.CrawlerHTML.Route (site) where


import              Snap.Core
import qualified    ISX.Plugin.CrawlerHTML.Zone.Common.Apex as  ZA
import qualified    ISX.Plugin.CrawlerHTML.Zone.Common.Data as  ZD
import qualified    PVK.Com.API.Zone.Common.Error           as  ZE


site :: Snap ()
site = ifTop ZA.apex <|> route [
    -- COMMON
    ("data",                            method POST     ZD.create),
    ("data/:_",                                         notFound),
    --
    ("",                                                notFound)]
    where
        notFound = ZE.notFound