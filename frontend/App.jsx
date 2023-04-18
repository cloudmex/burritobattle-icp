import React, { useCallback, useContext, useEffect, useState } from "react";
import logo from "./assets/dfinity.svg";
import {
  Box,
  Button,
  Flex,
  Image,
  Heading,
  Stack,
  Center,
  ChakraProvider,
  theme
} from '@chakra-ui/react';
import { PlugWallet } from "@connect2ic/core/providers/plug-wallet"

/*
 * Connect2ic provides essential utilities for IC app development
 */
import { createClient } from "@connect2ic/core";
import { defaultProviders } from "@connect2ic/core/providers";
import { ConnectButton, ConnectDialog, Connect2ICProvider } from "@connect2ic/react";
import "@connect2ic/core/style.css";
/*
 * Import canister definitions like this:
 */
import * as gotchi from "../.dfx/local/canisters/gotchi";
/*
 * Some examples to get you started
 */
import { Counter } from "./components/Counter";
import { Transfer } from "./components/Transfer";
import { Profile } from "./components/Profile";

import Header from "./components/Header";
import Gotchis from "./views/Gotchis";
import Mint from "./views/Mint";

function App() {
  const [view, setView] = useState("");
  const gotchis = async () => {
    setView("gotchis");
  };

  if (view != "gotchi" && view != "gotchis" && view != "mint") {
    return (
      <ChakraProvider theme={theme}>
        <ConnectDialog />
        <Center>
          <>
            <div style={{ width: '100%' }}>
              <Flex
                align="center"
                justify={{ base: "center", md: "space-around", xl: "space-between" }}
                direction={{ base: "column-reverse", md: "row" }}
                wrap="no-wrap"
                minH="70vh"
                px={8}
                mb={16}
              >
                <Stack
                  spacing={4}
                  w={{ base: "80%", md: "40%" }}
                  align={["center", "center", "flex-start", "flex-start"]}
                >
                  <Heading
                    as="h1"
                    size="xl"
                    fontWeight="bold"
                    color="primary.800"
                    textAlign={["center", "center", "left", "left"]}
                  >
                    Burrito Battle - ICP
                  </Heading>
                  <Heading
                    as="h2"
                    size="md"
                    color="primary.800"
                    opacity="0.8"
                    fontWeight="normal"
                    lineHeight={1.5}
                    textAlign={["center", "center", "left", "left"]}
                  >
                    To mint and interact with your virtual pets, connect your ICP account.
                  </Heading>
                  <ConnectButton 
                    dark={false} 
                    onConnect={() => {gotchis();}}
                  />
                  {/* <Button
                    bg='tomato'
                    colorScheme="primary"
                    borderRadius="8px"
                    py="4"
                    px="4"
                    lineHeight="1"
                    size="md"
                    onClick={async () => { gotchis(); }}
                  >
                    Siguiente
                  </Button> */}
                </Stack>
                <Box w={{ base: "80%", sm: "60%", md: "50%" }} mb={{ base: 12, md: 0 }}>
                  <Image src={"https://images.alphacoders.com/112/thumb-1920-1129289.jpg"} size="100%" rounded="1rem" shadow="2xl" mx="auto" />
                </Box>
              </Flex>
            </div>
          </>
        </Center>
      </ChakraProvider>
    )
  }

  if (view == "gotchis") {
    return (
      <ChakraProvider theme={theme}>
        <Center>
          <>
            <div style={{ width: '100%' }}>
              <div style={{ width: '100%', position: 'sticky', top: '0px', zIndex: '10' }}>
                <Header stateChanger={setView} />
              </div>
              <div style={{ width: '100%', marginBottom: '64px' }}>
                <Gotchis stateChanger={setView} />
              </div>
            </div>
          </>
        </Center>
      </ChakraProvider>
    )
  }
  if (view == "mint") {
    return (
      <ChakraProvider theme={theme}>
        <Center>
          <>
            <div style={{ width: '100%' }}>
              <div style={{ width: '100%', position: 'sticky', top: '0px', zIndex: '10' }}>
                <Header stateChanger={setView} />
              </div>
              <div style={{ width: '100%', marginBottom: '64px' }}>
                <Mint stateChanger={setView} />
              </div>
            </div>
          </>
        </Center>
      </ChakraProvider>
    )
  }
}

const client = createClient({
  providers: [
    new PlugWallet(),
  ],
  canisters: {
    gotchi,
  },
  //providers: defaultProviders,
  // globalProviderConfig: {
  //   /*
  //    * Disables dev mode in production
  //    * Should be enabled when using local canisters
  //    */
  //   dev: import.meta.env.DEV,
  // },
})

export default () => (
  <Connect2ICProvider client={client}>
    <App />
  </Connect2ICProvider>
)
