import React, { useCallback, useContext, useEffect, useState } from "react";
import {
  Box,
  Image,
  Center,
  Flex,
  Grid,
  GridItem,
  useColorModeValue,
  Badge,
  Text,
  HStack,
  Button
} from '@chakra-ui/react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { gotchi } from "../../.dfx/local/canisters/gotchi";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { useBalance, useWallet, useTransfer } from "@connect2ic/react";

export default function Gotchis({ stateChanger, ...rest }) {
  const [wallet] = useWallet();
  const [assets] = useBalance();
  const [gotchis, setGotchis] = React.useState();
  const [load, setLoad] = useState(false);
  const backgroundColor = useColorModeValue('white', 'gray.800');

  useEffect(() => {
    (async () => {
      setTimeout(async () => {
        let principal_id = wallet.principal;
        const tokens = await gotchi.getGotchisFromUser(principal_id);
        setTimeout(() => {
          setGotchis(tokens);
          setLoad(true);
        }, 100);
      }, 1000);
    })();
  }, []);

  async function sleepGotchi(id) {
    const sleep = await gotchi.sleep(parseInt(id));
    if (sleep.Ok.message !== "") {
      toast(sleep.Ok.message);
    }
    setTimeout(async () => {
      let principal_id = wallet.principal;
      const tokens = await gotchi.getGotchisFromUser(principal_id);

      setTimeout(() => {
        setGotchis(tokens);
        setLoad(true);
      }, 100);
    }, 100);
  }

  async function playGotchi(id) {
    const play = await gotchi.play(parseInt(id));
    if (play.Ok.message !== "") {
      toast(play.Ok.message);
    }
    setTimeout(async () => {
      let principal_id = wallet.principal;
      const tokens = await gotchi.getGotchisFromUser(principal_id);

      setTimeout(async () => {

        setGotchis(tokens);
        setLoad(true);
      }, 100);
    }, 100);
  }


  async function feedGotchi(id) {
    const feed = await gotchi.feed(parseInt(id));
    if (feed.Ok.message !== "") {
      toast(feed.Ok.message);
    }
    setTimeout(async () => {
      let principal_id = wallet.principal;
      const tokens = await gotchi.getGotchisFromUser(principal_id);

      setTimeout(() => {
        setGotchis(tokens);
        setLoad(true);
      }, 100);
    }, 100);
  }

  const getDate = (timestamp) => {
    if (!timestamp) { return; }
    var newDate = new Date();
    var options = { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' };
    newDate.setTime(timestamp.toString().substring(0, 13));
    return newDate.toLocaleDateString('es-ES', options);
  }

  return (
    <>
      <ToastContainer
        position="top-right"
        autoClose={5000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="colored"
      />
      <Grid templateColumns={{ base: 'repeat(1, 1fr)', sm: 'repeat(1, 1fr)', md: 'repeat(2, 2fr)', lg: 'repeat(3, 3fr)', xl: 'repeat(3, 3fr)' }}>
        {load && gotchis.map((gotchi) => (
          <GridItem key={gotchi.id}>
            <Flex p={50} w="full" alignItems="center" justifyContent="center">
              <Box
                bg={backgroundColor}
                maxW="sm"
                borderWidth="1px"
                rounded="lg"
                shadow="lg"
                position="relative">
                <Center>
                  <Image
                    src={gotchi.metadata.image}
                    roundedTop="lg"
                    width="50%"
                  />
                </Center>
                <Box p="6" textAlign={'center'}>
                  <Box d="flex" alignItems="baseline">
                    <Badge rounded="full" px="2" fontSize="0.8em" colorScheme="yellow" fontWeight="black">
                      {gotchi.metadata.name}
                    </Badge>
                  </Box>
                  <br />
                  {(gotchi.metadata.properties.lastMeal > 0) && <Box d="flex" alignItems="baseline">
                    <b>Last meal:</b> {getDate(gotchi.metadata.properties.lastMeal)}
                  </Box>}
                  <br />
                  <HStack w="100%" justify="space-evenly">
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Text casing="capitalize" fontWeight="bold">
                        Health
                      </Text>
                      <Text>{gotchi.metadata.properties.health.toString()}</Text>
                    </Flex>
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Text casing="capitalize" fontWeight="bold">
                        Hunger
                      </Text>
                      <Text>{gotchi.metadata.properties.hunger.toString()}</Text>
                    </Flex>
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Text casing="capitalize" fontWeight="bold">
                        Dream
                      </Text>
                      <Text>{gotchi.metadata.properties.sleep.toString()}</Text>
                    </Flex>
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Text casing="capitalize" fontWeight="bold">
                        Happiness
                      </Text>
                      <Text>{gotchi.metadata.properties.happiness.toString()}</Text>
                    </Flex>
                  </HStack>
                  <HStack w="100%" justify="space-evenly">
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Button
                        mt={4}
                        colorScheme='teal'
                        type='submit'
                        onClick={async () => { playGotchi(gotchi.id); }}
                      >
                        Play
                      </Button>
                    </Flex>
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Button
                        mt={4}
                        colorScheme='orange'
                        type='submit'
                        onClick={async () => { feedGotchi(gotchi.id); }}
                      >
                        Feed
                      </Button>
                    </Flex>
                    <Flex
                      fontSize="xs"
                      justify="center"
                      align="center"
                      direction="column">
                      <Button
                        mt={4}
                        colorScheme='yellow'
                        type='submit'
                        onClick={async () => { sleepGotchi(gotchi.id); }}
                      >
                        Sleep
                      </Button>
                    </Flex>
                  </HStack>
                </Box>
              </Box>
            </Flex>
          </GridItem>
        ))}
      </Grid>
    </>
  )

}
