import React, { useCallback, useContext, useEffect, useState } from "react";
import { MoonIcon, SunIcon } from '@chakra-ui/icons';
import {
  Box,
  Flex,
  Text,
  Avatar,
  IconButton,
  Button,
  Divider,
  Stack,
  Collapse,
  Icon,
  Link,
  Popover,
  PopoverTrigger,
  PopoverContent,
  useColorModeValue,
  useBreakpointValue,
  useDisclosure,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  MenuDivider,
  useColorMode,
  Center,
  Grid,
  GridItem
} from '@chakra-ui/react';
import {
  HamburgerIcon,
  CloseIcon,
  ChevronDownIcon,
  ChevronRightIcon,
} from '@chakra-ui/icons';
import { ConnectButton, ConnectDialog, Connect2ICProvider } from "@connect2ic/react";
import "@connect2ic/core/style.css";
import { useBalance, useWallet } from "@connect2ic/react";
import logo from "../assets/dfinity.svg";

export default function WithSubnavigation({ stateChanger, ...rest }) {
  const [wallet] = useWallet();
  const [assets] = useBalance();
  const { colorMode, toggleColorMode } = useColorMode();
  const linkColor = useColorModeValue('gray.600', 'gray.200');
  const linkHoverColor = useColorModeValue('gray.800', 'white');
  const popoverContentBgColor = useColorModeValue('gray.200', 'gray.700');
  async function changeView(view) {
    stateChanger(view);
  }

  return (
    <Box w='100%'>
      <ConnectDialog />
      <Flex
        bg={useColorModeValue('white', 'gray.800')}
        color={useColorModeValue('gray.600', 'white')}
        minH={'60px'}
        py={{ base: 2 }}
        px={{ base: 4 }}
        borderBottom={1}
        borderStyle={'solid'}
        borderColor={useColorModeValue('gray.200', 'gray.900')}
        align={'center'}>
        <Flex flex={{ base: 1 }} justify={{ base: 'center', md: 'start' }}>
          <Flex display={{ base: 'flex', md: 'flex' }} ml={10}>
            <Stack direction={'row'} spacing={4}>
              <Box>
                <Popover trigger={'hover'} placement={'bottom-start'}>
                  <PopoverTrigger>
                    <Link
                      p={2}
                      onClick={async () => { changeView("gotchis"); }}
                      fontSize={'sm'}
                      fontWeight={500}
                      color={linkColor}
                      rounded={'md'}
                      _hover={{
                        textDecoration: 'none',
                        color: linkHoverColor,
                        bg: popoverContentBgColor
                      }}>
                      Gotchis
                    </Link>
                  </PopoverTrigger>
                </Popover>
              </Box>
              <Box>
                <Popover trigger={'hover'} placement={'bottom-start'}>
                  <PopoverTrigger>
                    <Link
                      p={2}
                      onClick={async () => { changeView("mint"); }}
                      fontSize={'sm'}
                      fontWeight={500}
                      color={linkColor}
                      rounded={'md'}
                      _hover={{
                        textDecoration: 'none',
                        color: linkHoverColor,
                        bg: popoverContentBgColor
                      }}>
                      Minar
                    </Link>
                  </PopoverTrigger>
                </Popover>
              </Box>
            </Stack>
          </Flex>
        </Flex>

        {wallet ? (
          <>
            <Flex alignItems={'center'}>
              <Stack direction={'row'} spacing={7}>
                <Button onClick={toggleColorMode}>
                  {colorMode === 'light' ? <MoonIcon /> : <SunIcon />}
                </Button>

                <Menu>
                  <MenuButton
                    as={Button}
                    rounded={'full'}
                    variant={'link'}
                    cursor={'pointer'}
                    minW={0}>
                    <Avatar
                      name={"A"}
                      src={logo}
                      size={'sm'}
                      width={'auto'}
                    />
                  </MenuButton>
                  <MenuList alignItems={'center'}>
                    <br />
                    <Center>
                      <Avatar
                        size={'sm'}
                        name={"A"}
                        src={logo}
                        width={'auto'}
                      />
                    </Center>
                    <br />
                    <Center>
                      <Grid templateColumns='repeat(1, 1fr)' gap={6}>
                        <GridItem w='100%' h='10'>
                          <p>Wallet address: <span style={{ fontSize: "0.7em" }}>{wallet ? (wallet.principal.substring(0, 5) + ".." + wallet.principal.substring(wallet.principal.length - 3, wallet.principal.length)) : "-"} </span></p><br />
                        </GridItem>
                        {assets && assets.map(asset => (
                          <GridItem w='100%' key={asset.canisterId}>
                            {asset.name}: {asset.amount}
                          </GridItem>
                        ))}
                      </Grid>
                    </Center>
                    <br />
                    <MenuDivider />
                    <Center>
                      <ConnectButton dark={false} />
                    </Center>
                  </MenuList>
                </Menu>
              </Stack>
            </Flex>
          </>
        ) : (
          <ConnectButton />
        )}
      </Flex>
    </Box>
  );
}